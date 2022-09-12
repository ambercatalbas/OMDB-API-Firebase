//
//  SplashViewController.swift
//  OMDB-API-Firebase
//
//  Created by Amber Çatalbaş on 11.09.2022.
//

import UIKit

final class SplashViewController: BaseViewController<SplashViewModel> {
    
    private let lblTitle = UILabelBuilder()
        .font(.font(.josefinSansSemibold, size: .custom(size: 22)))
        .textColor(.appCinder)
        .numberOfLines(0)
        .build()
    private let btnTryAgain = UIButtonBuilder()
        .title(L10n.HomeViewController.searchButtonTitle)
        .backgroundColor(.appGreen)
        .tintColor(.appBlueBerry)
        .titleFont(.font(.josefinSansBold, size: .custom(size: 12)))
        .cornerRadius(14)
        .isHidden(true)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isConnect()
        addSubview()
    }
    
    func isConnect() {
       if ReachabilityManager.shared.isConnected {
        fetchRC()
        } else {
            showAlert()
        }
    }
    
    func showAlert() {
        self.showFailureWarningToast(message: L10n.SplashViewController.disconnect )
        self.lblTitle.text = L10n.SplashViewController.disconnect
        self.btnTryAgain.isHidden = false
    }
    
    func fetchRC() {
        if RCValues.sharedInstance.fetchComplete {
             showHome()
         }
        RCValues.sharedInstance.loadingDoneCallback = showHome
    }
    
    func showHome() {
        lblTitle.text = RCValues.sharedInstance.string(forKey: .appName)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { timer in
            self.viewModel.showHome()
        })
        
    }
}

// MARK: - UILayout
extension SplashViewController {
    func addSubview() {
        view.addSubview(lblTitle)
        lblTitle.centerInSuperview()
        
        view.addSubview(btnTryAgain)
        btnTryAgain.topToBottom(of: lblTitle).constant = 30
        btnTryAgain.leftToSuperview().constant = 40
        btnTryAgain.rightToSuperview().constant = -40
        btnTryAgain.height(40)
    
    }
}

// MARK: - Configure
extension SplashViewController {
    func configureContents() {
        btnTryAgain.setTitle(L10n.SplashViewController.tryAgain, for: .normal)
    }
}
