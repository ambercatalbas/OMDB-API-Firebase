//
//  PlaceOnWindowTransition.swift
//  Routing
//
//  Created by Nikita Ermolenko on 29/09/2017.
//

import UIKit

class PlaceOnWindowTransition: Transition {
    
    var viewController: UIViewController?
    
    func open(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.first else { return }
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            UIView.performWithoutAnimation {
                window.rootViewController = viewController
            }
        }, completion: nil)
    }
    
    func close(_ viewController: UIViewController) {}
    
}
