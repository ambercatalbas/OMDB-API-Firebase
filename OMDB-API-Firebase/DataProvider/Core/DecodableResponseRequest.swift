//
//  DecodableResponseRequest.swift
//  DataProvider
//
//  Created by AMBER ÇATALBAŞ on 9.03.2022.
//

public protocol DecodableResponseRequest: RequestProtocol {
    associatedtype ResponseType: Decodable
}
