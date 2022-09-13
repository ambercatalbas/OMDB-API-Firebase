//
//  RequestProtocol.swift
//  DataProvider
//
//  Created by AMBER ÇATALBAŞ on 9.03.2022.
//

public protocol RequestProtocol {
    var path: String { get }
    var method: RequestMethod { get }
    var parameters: RequestParameters { get }
    var headers: RequestHeaders { get }
    var encoding: RequestEncoding { get }
    var url: String { get }
}
