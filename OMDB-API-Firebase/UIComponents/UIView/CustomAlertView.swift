//
//  CustomAlertView.swift
//  OMDB-API-Firebase
//
//  Created by Amber Çatalbaş on 11.09.2022.
//

import UIKit

protocol CustomAlertViewButtonActionDelegate: AnyObject {
    func alertButtonAction(buttonTag: Int)
}

class CustomAlertView: UIView, AlertModal {

    weak var delegate: CustomAlertViewButtonActionDelegate?

    var backgroundView = UIView()
    var dialogView = UIView()
    let buttonleft = UIButton()
    let buttonright = UIButton()
    let buttonSingle = UIButton()

    convenience init(title: String?, image: UIImage?, message: String?, titleHeight: CGFloat?, messageHeight: CGFloat?, imageHeight: CGFloat?, bnum: ButtonCount) {
        self.init(frame: UIScreen.main.bounds)
        initialize(title: title, image: image, message: message, titleHeight: titleHeight, messageHeight: messageHeight, imageHeight: imageHeight, bNum: bnum)

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    @objc func didTappedOnBackgroundView() {
        //dismiss(animated: true)
    }

    // ----------------

    func initialize(title: String?, image: UIImage?, message: String?, titleHeight: CGFloat?, messageHeight: CGFloat?, imageHeight: CGFloat?, bNum: ButtonCount) {
        dialogView.clipsToBounds = true

        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.darkGray
        backgroundView.alpha = 0.8
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)

        let dialogViewWidth = frame.width - 64

        let imageView = UIImageView()
        var titleView = UIView()
        var titleLabel = UILabel()
        var messageLabel = UILabel()
        var messageView = UIView()

        let fullString = NSMutableAttributedString(string: "")
        let imageAttach = NSTextAttachment()
        imageAttach.image = #imageLiteral(resourceName: "EOUnlem")
        let imageString = NSAttributedString(attachment: imageAttach)
        fullString.append(imageString)
        fullString.append(NSAttributedString(string: ""))
        titleLabel.attributedText = fullString
        messageLabel.text = message
        imageView.image = image

//        if titleLabel.text != nil {
//
        titleView = UIView(frame: CGRect(x: 0, y: 0, width: dialogViewWidth, height: titleHeight! + CGFloat(12)))
        titleLabel = UILabel(frame: CGRect(x: -15, y: 20, width: dialogViewWidth, height: titleHeight! - CGFloat(8)))
//            titleLabel.numberOfLines = 0
        titleLabel.attributedText = fullString
        titleLabel.font = .font(.josefinSansBold, size: .custom(size: 16))
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleView.backgroundColor = UIColor.lightGray
        titleView.addSubview(titleLabel)
        dialogView.addSubview(titleView)
//        } else {
//            titleView = UIView(frame: CGRect(x: 0, y: 0 , width: dialogViewWidth, height: titleHeight!))
//            dialogView.addSubview(titleView)
//        }


        if imageView.image != nil {
            imageView.frame.origin = CGPoint(x: 100, y: titleLabel.frame.height + titleLabel.frame.origin.y + 30)
            imageView.frame.size = CGSize(width: dialogViewWidth - 200, height: dialogViewWidth - 200)
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.layer.cornerRadius = 4
            imageView.clipsToBounds = true
            dialogView.addSubview(imageView)
        } else {
            imageView.image = nil
            imageView.frame.origin = CGPoint(x: 0, y: titleLabel.frame.height + titleLabel.frame.origin.y + 0)
            dialogView.addSubview(imageView)
        }

        if messageLabel.text != nil {

            messageView = UIView(frame: CGRect(x: 0, y: imageView.frame.height + imageView.frame.origin.y, width: dialogViewWidth - 20, height: messageHeight!))

            messageLabel = UILabel(frame: CGRect(x: 5, y: -10, width: messageView.frame.width - 15, height: messageHeight!))

            messageLabel.text = message
            messageLabel.numberOfLines = 0
            messageLabel.font = .font(.josefinSansMedium, size: .custom(size: 14))
            messageLabel.textColor = .white
            messageLabel.textAlignment = .center
            messageView.backgroundColor = UIColor.lightGray
            messageView.addSubview(messageLabel)
            dialogView.addSubview(messageView)

        } else {
            messageView = UIView(frame: CGRect(x: 0, y: imageView.frame.height + imageView.frame.origin.y, width: dialogViewWidth, height: 0))
            dialogView.addSubview(messageView)
        }

        var stackBottom = UIStackView()
        var stackBackView = UIView()
        let separatorLineView3 = UIView()
        let separatorLineView4 = UIView()

        switch bNum {
        case ButtonCount.multipleButton:

            stackBackView = UIView(frame: CGRect(x: 8, y: messageLabel.frame.height + messageLabel.frame.origin.y + 8, width: dialogViewWidth - 16, height: 50))
            stackBackView.backgroundColor = UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1)

            stackBottom = UIStackView(frame: CGRect(x: 8, y: messageLabel.frame.height + messageLabel.frame.origin.y + 8, width: dialogViewWidth - 16, height: 50))

            buttonleft.backgroundColor = UIColor.white
            buttonright.backgroundColor = UIColor.white

            buttonleft.setTitle("Cancel", for: .normal)
            buttonleft.setTitleColor(UIColor.red, for: .normal)
            buttonleft.tag = 1 //0- Single button 1- Left Button for Multiple Button 2 - Right Button for Multiple Button
            buttonleft.addTarget(nil, action: #selector(buttonTapped(sender:)), for: .touchUpInside)

            buttonright.setTitle("OK", for: .normal)
            buttonright.setTitleColor(UIColor.blue, for: .normal)
            buttonright.tag = 2 //0- Single button 1- Left Button for Multiple Button 2 - Right Button for Multiple Button
            buttonright.addTarget(nil, action: #selector(buttonTapped(sender:)), for: .touchUpInside)

            stackBottom.axis = .horizontal
            stackBottom.alignment = .fill
            stackBottom.distribution = .fillEqually
            stackBottom.spacing = 1

            stackBottom.addArrangedSubview(buttonleft)
            stackBottom.addArrangedSubview(buttonright)

            separatorLineView3.frame.origin = CGPoint(x: 30, y: messageLabel.frame.height + messageLabel.frame.origin.y + 7)
            separatorLineView3.frame.size = CGSize(width: dialogViewWidth - 60, height: 1)
            separatorLineView3.backgroundColor = UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1)
            dialogView.addSubview(separatorLineView3)

            separatorLineView4.frame.origin = CGPoint(x: 30, y: messageLabel.frame.height + messageLabel.frame.origin.y + 58)
            separatorLineView4.frame.size = CGSize(width: dialogViewWidth - 60, height: 1)
            separatorLineView4.backgroundColor = UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1)
            dialogView.addSubview(separatorLineView4)

        case ButtonCount.singleButton:

            stackBackView = UIView(frame: CGRect(x: 0, y: messageView.frame.height + messageView.frame.origin.y, width: dialogViewWidth, height: 50))
            stackBackView.applyGradientWihPoints(firstColor: UIColor.yellow.cgColor, lastColor: UIColor.yellow.cgColor, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1), ndLayer: 0)
            stackBottom = UIStackView(frame: CGRect(x: 0, y: messageView.frame.height + messageView.frame.origin.y, width: dialogViewWidth, height: 50))

            buttonSingle.setTitleColor(UIColor.darkGray, for: .normal)
            buttonSingle.titleLabel?.font = .font(.josefinSansBold, size: .custom(size: 16))
            buttonSingle.contentHorizontalAlignment = .center
            buttonSingle.titleLabel?.contentMode = .center
            buttonSingle.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            buttonSingle.tag = 0 //0- Single button 1- Left Button for Multiple Button 2 - Right Button for Multiple Button
            buttonSingle.addTarget(nil, action: #selector(buttonTapped(sender:)), for: .touchUpInside)

            stackBottom.addArrangedSubview(buttonSingle)

        case ButtonCount.nonButton:
            print("Non Button")
        }


        dialogView.addSubview(stackBackView)
        dialogView.addSubview(stackBottom)

        var dialogViewHeight: CGFloat!

        if imageView.image == nil {
            dialogViewHeight = titleView.frame.height + messageView.frame.height + stackBackView.frame.height
        } else {
            dialogViewHeight = titleView.frame.height + imageView.frame.height + messageView.frame.height + stackBackView.frame.height
        }


        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width - 84, height: dialogViewHeight)
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 8
        dialogView.clipsToBounds = true
        addSubview(dialogView)

    }

    @objc func buttonTapped(sender: UIButton) {
        delegate?.alertButtonAction(buttonTag: sender.tag)
    }
}

enum ButtonCount {
    case multipleButton
    case singleButton
    case nonButton
}
