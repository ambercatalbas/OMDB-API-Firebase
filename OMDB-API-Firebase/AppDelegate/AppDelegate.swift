//
//  AppDelegate.swift
//  OMDB-API-Firebase
//
//  Created by Amber Çatalbaş on 10.09.2022.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      let bounds = UIScreen.main.bounds
      self.window = UIWindow(frame: bounds)
      AppRouter.shared.startApp()
      self.window?.makeKeyAndVisible()
    return true
  }
}

