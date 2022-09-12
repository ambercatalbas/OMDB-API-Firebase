//
//  HomeCellModel.swift
//  NoteMVVMR
//
//  Created by Amber Çatalbaş on 10.09.2022.
//

import Foundation

public protocol HomeCellDataSource: AnyObject {
    var titleText: String { get set }
}

public protocol HomeCellEventSource: AnyObject {
    
}

public protocol HomeCellProtocol: HomeCellDataSource, HomeCellEventSource {
    
}

public final class HomeCellModel: HomeCellProtocol {
    
    public var titleText: String
    
    public init(title: String) {
        self.titleText = title
    }
}
