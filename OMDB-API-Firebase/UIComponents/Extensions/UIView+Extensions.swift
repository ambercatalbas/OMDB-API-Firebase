//
//  UIView+Extensions.swift
//  OMDB-API-Firebase
//
//  Created by Amber Çatalbaş on 11.09.2022.
//

import Foundation

extension UIView {
    func applyGradientWihPoints(firstColor: CGColor, lastColor: CGColor, startPoint: CGPoint, endPoint: CGPoint, ndLayer: UInt32) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width + 100, height: self.bounds.height)
        gradient.colors = [firstColor, lastColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: ndLayer)
    }
}
