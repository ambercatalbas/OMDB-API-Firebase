//
//  HomeSection.swift
//  DataProvider
//
//  Created by Amber Çatalbaş on 11.09.2022.
//

import UIKit

public class HomeSection {
    public var type: HomeSectionType
    public var items: [Any]?
    public var itemCount: Int?

    init(type: HomeSectionType, items: [Any]? = nil, itemCount: Int? = nil) {
        self.type = type
        self.items = items
        self.itemCount = itemCount
    }
}
