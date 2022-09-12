//
//  ReusableView.swift
//  UIComponents
//
//  Created by Amber Çatalbaş on 10.09.2022.
//

public protocol ReusableView: AnyObject {
  static var defaultReuseIdentifier: String { get }
}
