//
//  APIRequest.swift
//  DataProvider
//
//  Created by AMBER ÇATALBAŞ on 9.03.2022.
//

public protocol APIDecodableResponseRequest: DecodableResponseRequest {}

// MARK: - RequestEncoding
public extension APIDecodableResponseRequest {
    var encoding: RequestEncoding {
        switch method {
        case .get:
            return .url
        default:
            return .json
        }
    }
}

// MARK: - url
public extension APIDecodableResponseRequest {
    
    var url: String {
        let apiKey = "bf9fd116"
        return "https://www.omdbapi.com/" + String(format: "?apikey=%@", apiKey) + path
    }
}

// MARK: - RequestParameters
public extension APIDecodableResponseRequest {
    var parameters: RequestParameters {
        return [:]
    }
}

// MARK: - RequestHeaders
public extension APIDecodableResponseRequest {
    var headers: RequestHeaders {
        return [:]
    }
}
