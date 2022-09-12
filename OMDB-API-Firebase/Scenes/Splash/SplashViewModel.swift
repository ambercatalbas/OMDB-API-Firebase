//
//  SplashViewModel.swift
//  OMDB-API-Firebase
//
//  Created by Amber Çatalbaş on 11.09.2022.
//

import Foundation

protocol SplashViewDataSource {}

protocol SplashViewEventSource {}

protocol SplashViewProtocol: SplashViewDataSource, SplashViewEventSource {
    func showHome()
}

final class SplashViewModel: BaseViewModel<SplashRouter>, SplashViewProtocol {
    func showHome() {
        router.placeOnWindowHome()
    }
    
    
}
