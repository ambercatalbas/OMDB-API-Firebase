//
//  GetMoviesRequest.swift
//  DataProvider
//
//  Created by Amber Çatalbaş on 10.09.2022.
//

public struct GetMoviesRequest: APIDecodableResponseRequest {
 
    public typealias ResponseType = MovieListResponse
    
    public var path: String = ""
    public var method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    public var headers: RequestHeaders = [:]
    
    public init(title: String) {
        parameters["s"] = title
        
    }
    
}
