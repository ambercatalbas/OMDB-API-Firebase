//
//  DetailRoute.swift
//  OMDB-API-Firebase
//
//  Created by Amber Çatalbaş on 10.09.2022.
//


protocol DetailRoute {
    
    func pushDetail(movie: Movie)
}

extension DetailRoute where Self: RouterProtocol {
    
    func pushDetail(movie: Movie) {
        let router = DetailRouter()
        let viewModel = DetailViewModel(movie: movie, router: router)
        let viewController = DetailViewController(viewModel: viewModel)
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }

}
