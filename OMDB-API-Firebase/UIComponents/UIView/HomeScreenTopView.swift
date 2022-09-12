//
//  HomeScreenTopView.swift
//  UIComponents
//
//  Created by Amber Çatalbaş on 10.09.2022.
//

import UIKit

public class HomeScreenTopView: UIView {
    
    public let searchTextField = UITextFieldBuilder()
        .cornerRadius(4)
        .borderColor(UIColor.appTextFieldBorderColor.cgColor)
        .placeholder(L10n.HomeViewController.searchPlaceholder)
        .font(.font(.josefinSansRegular, size: .custom(size: 13)))
        .build()
    private let searchButton = UIButtonBuilder()
        .title(L10n.HomeViewController.searchButtonTitle)
        .backgroundColor(.appGreen)
        .tintColor(.appBlueBerry)
        .titleFont(.font(.josefinSansBold, size: .custom(size: 12)))
        .cornerRadius(14)
        .build()
    private let lineView = UIViewBuilder()
        .backgroundColor(.appLineViewColor)
        .build()
    
    public var searchTextFieldTapped: StringClosure?
    weak var viewModel: HomeScreenTopViewProtocol?
    
    public var isEnableSearchButton: Bool = false {
        didSet {
            if isEnableSearchButton {
                searchButton.backgroundColor = UIColor.appGreen.withAlphaComponent(1)
                searchButton.isEnabled = true
            } else {
                searchButton.backgroundColor = UIColor.appGreen.withAlphaComponent(0.33)
                searchButton.isEnabled = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
    }
    
    private func configureContents() {
        backgroundColor = .clear
        makeSearchTextField()
        makeCancelButton()
        makeLineView()
        searchTextField.withImage(direction: .left,
                                  image: .searchIcon,
                                  colorSeparator: UIColor.white,
                                  colorBorder: .appRaven,
                                  backgroundColor: .white)
        searchTextField.returnKeyType = .done
        searchTextField.addTarget(self, action: #selector(textSearchChange(_:)), for: .editingChanged)
        searchButton.addTarget(self,
                               action: #selector(searchTapped),
                               for: .touchUpInside)
        isEnableSearchButton = false

    }
    
    private func makeSearchTextField() {
        addSubview(searchTextField)
        searchTextField.topToSuperview()
        searchTextField.leadingToSuperview().constant = 25
        searchTextField.height(40)
        searchTextField.bottomToSuperview().constant = -5
        searchTextField.centerYToSuperview()
    }
    
    private func makeCancelButton() {
        addSubview(searchButton)
        searchButton.leadingToTrailing(of: searchTextField).constant = 5
        searchButton.trailingToSuperview().constant = -5
        searchButton.centerY(to: searchTextField)
        searchButton.width(40)
        searchButton.height(30)
    }
    
    private func makeLineView() {
        addSubview(lineView)
        lineView.height(1)
        lineView.leadingToSuperview()
        lineView.trailingToSuperview()
        lineView.bottomToSuperview()
    }
    
}

// MARK: - Actions
extension HomeScreenTopView {
    
    public func set(viewModel: HomeScreenTopViewProtocol) {
        self.viewModel = viewModel
        searchTextField.placeholder = viewModel.placeholderText
    }
    
    @objc
    private func searchTapped() {
        searchTextFieldTapped?(searchTextField.text ?? "")
    }
    
    @objc
    private func textSearchChange(_ sender: UITextField) {
        if sender.text == "" {
            isEnableSearchButton = false
        } else {
            isEnableSearchButton = true
        }
    }
}
