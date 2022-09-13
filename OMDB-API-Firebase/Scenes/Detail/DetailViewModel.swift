//
//  DetailViewModel.swift
//  OMDB-API-Firebase
//
//  Created by Amber Çatalbaş on 10.09.2022.
//

import Foundation
import Alamofire

protocol DetailViewDataSource {
    var movie: Movie { get }
}

protocol DetailViewEventSource {}

protocol DetailViewProtocol: DetailViewDataSource, DetailViewEventSource {
    func showHomeScreen()
}

final class DetailViewModel: BaseViewModel<DetailRouter>, DetailViewProtocol {
    var movie: Movie
    
    init(movie: Movie, router: DetailRouter) {
        self.movie = movie
        super.init(router: router)
    }
    
    func showHomeScreen() {
        router.close()
    }

}
