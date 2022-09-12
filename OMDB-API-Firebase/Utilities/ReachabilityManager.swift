//
//  ReachabilityManager.swift
//  DataProvider
//
//  Created by Amber Çatalbaş on 11.09.2022.
//

import UIKit
import Reachability

class ReachabilityManager: NSObject, CustomAlertViewButtonActionDelegate {
    static let shared = ReachabilityManager()
    
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .unavailable
    }

    var isConnected: Bool {
        return ReachabilityManager.shared.reachability.connection != .unavailable
    }
    
    var alert:CustomAlertView!
    
    var reachabilityStatus: Reachability.Connection = .unavailable
    
    let reachability = try! Reachability()
    
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }
    
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
    
    @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability
        switch reachability.connection {
        case .unavailable,.none:
            
            self.showAlertSingleButton(title: "", image: nil, message: "İstek zaman aşımına uğradı. \nLütfen internet bağlantınızı kontrol edin.", titleHeight: 40, messageHeight: 70, imageHeight: nil, buttonTitle: "Ayarlara Git")
            print("Network became unreachable")
        case .wifi:
            print("Network reachable through WiFi")
        case .cellular:
            print("Network reachable through Cellular Data")

        }
    }
    
    func checkNetworkConnection() -> Bool {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            self.showAlertSingleButton(title: "", image: nil, message: "İstek zaman aşımına uğradı. \nLütfen internet bağlantınızı kontrol edin.", titleHeight: 40, messageHeight: 70, imageHeight: nil, buttonTitle: "Tamam")
            return false
        } else {
            return true
        }
    }
    
    func showAlertSingleButton(title:String?, image:UIImage?, message:String?, titleHeight:CGFloat?, messageHeight:CGFloat?, imageHeight:CGFloat? ,buttonTitle:String ){
        self.alert = CustomAlertView(title: title,  image: image, message: message,titleHeight:titleHeight , messageHeight:messageHeight , imageHeight:imageHeight , bnum: ButtonCount.singleButton)
        self.alert.buttonSingle.setTitle(buttonTitle, for: .normal)
        self.alert.delegate = self
        self.alert.show(animated: true)
    }
    
    func alertButtonAction(buttonTag: Int) {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                        // Handle
                })
            } else {
                       // Fallback on earlier versions
            }
        }
        alert.dismiss(animated: true)
    }
    
}
