//
//  HomeViewModel.swift
//  OMDB-API-Firebase
//
//  Created by Amber Çatalbaş on 10.09.2022.
//

import Foundation
import DataProvider

protocol HomeViewDataSource {
    var sectionListSource: [HomeSection] { get }
    var movies: [Movie] { get }
    func numberOfItemsAt(section: Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> HomeCellProtocol
}

protocol HomeViewEventSource {
    var didSuccessMovies: VoidClosure? { get }
}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {
    func didSelectRow(indexPath: IndexPath) 
    func fetchMoviesListing(title: String)
}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    var movies: [Movie] = []
    var sectionListSource: [HomeSection] = []
    var didSuccessMovies: VoidClosure?
    var cellItems: [HomeCellProtocol] = [HomeCellModel(title: "")]
    
    func didSelectRow(indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        router.pushDetail(movie: movie )
    }
    
    func numberOfItemsAt(section: Int) -> Int {
        return cellItems.count
        
    }
    
    func cellItemAt(indexPath: IndexPath) -> HomeCellProtocol {
        let item = cellItems[indexPath.row]
        return item
    }
    
}

// MARK: - Network
extension HomeViewModel {
    
    func fetchMoviesListing(title: String) {
       
        let request = GetMoviesRequest(title: title)

        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if response.error != nil {
                    self.showFailureWarningToast?(String(format: "%@", response.error ?? "Error"))
                } else {
                    self.cellItems.removeAll(keepingCapacity: false)
                    let items = response.search?.map({ HomeCellModel(title: $0.title ?? "") })
                    self.cellItems = items ?? []
                    self.sectionListSource = response.homeItemList
                    self.movies = response.search ?? []
                    self.didSuccessMovies?()
                }
          
            case .failure(let error):
                self.showFailureWarningToast?("\(error.localizedDescription)")
            }
        }
    }
    
    func rowCount(_ section: Int) -> Int{
        let data = self.sectionListSource[section]
        
        if let itemCount = data.itemCount {
            return itemCount
        }else {
            return data.items?.count ?? 0
        }
    }
    
}
