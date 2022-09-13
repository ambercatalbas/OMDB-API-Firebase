//
//  MovieListResponse.swift
//  DataProvider
//
//  Created by AMBER ÇATALBAŞ on 18.03.2022.
//

import Foundation

// MARK: - MovieListResponse
public struct MovieListResponse: Codable {
    public let search: [Movie]?
    public let totalResults, response: String?
    public let error: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }

    public init(search: [Movie]?, totalResults: String?, response: String?, error: String?) {
        self.search = search
        self.totalResults = totalResults
        self.response = response
        self.error = error
    }
}

// MARK: - Movie
public struct Movie: Codable {
    public let title, year, imdbID: String?
    public let type: String?
    public let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }

    public init(title: String?, year: String?, imdbID: String?, type: String?, poster: String?) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
    }
}

extension MovieListResponse {
    public var homeItemList: [HomeSection] {
        var list = [HomeSection]()

        guard let search = self.search else {
            return list
        }
        let items = search.map({ HomeCellItem(title: $0.title ?? "") })
            list.append(HomeSection(type: .item, items: items))
        return list
    }
}
