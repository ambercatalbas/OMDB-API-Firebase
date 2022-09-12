//
//  RCValues.swift
//  OMDB-API-Firebase
//
//  Created by Amber Çatalbaş on 10.09.2022.
//

import Foundation
import Firebase

enum ValueKey: String {
  case appPrimaryColor
  case appName
}

class RCValues {
  static let sharedInstance = RCValues()
  var loadingDoneCallback: (() -> Void)?
  var fetchComplete = false

  private init() {
    loadDefaultValues()
    fetchCloudValues()
  }

  func loadDefaultValues() {
    let appDefaults: [String: Any?] = [
      ValueKey.appPrimaryColor.rawValue: "#FBB03B",
      ValueKey.appName.rawValue: "OMDB-API-Firebase"
    ]
    RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
  }

  func fetchCloudValues() {
    activateDebugMode()

    RemoteConfig.remoteConfig().fetch { [weak self] _, error in
      if let error = error {
        print("Uh-oh. Got an error fetching remote values \(error)")
        return
      }

      RemoteConfig.remoteConfig().activate { [weak self] _, _ in
        print("Retrieved values from the cloud!")
        self?.fetchComplete = true
        DispatchQueue.main.async {
          self?.loadingDoneCallback?()
        }
      }
    }
  }

  func activateDebugMode() {
    let settings = RemoteConfigSettings()
    settings.minimumFetchInterval = 0
    RemoteConfig.remoteConfig().configSettings = settings
  }

  func color(forKey key: ValueKey) -> UIColor {
      let colorAsHexString = RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? "#FFFFFFFF"
      guard let convertedColor = UIColor(named: colorAsHexString) else { return UIColor.systemTeal }
    return convertedColor
  }

  func string(forKey key: ValueKey) -> String {
    RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
  }

}
