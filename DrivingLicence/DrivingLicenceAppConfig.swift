//
//  AppConfig.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 22.03.2023.
//

import Foundation
import RealmSwift

/// Store the Realm app details to use when instantiating the app and
/// when using the `@AsyncOpen` property wrapper to open the realm.
struct DrivingLicenceAppConfig {
    var appId: String
    var baseUrl: String
    var localAppVersion : String
    var apiKey : String
}

/// Read the atlasConfig.plist file and store the app ID and baseUrl to use elsewhere.
func loadDrivingLicenceAppConfig() -> DrivingLicenceAppConfig {
    guard let path = Bundle.main.path(forResource: "atlasConfig", ofType: "plist") else {
        fatalError("Could not load atlasConfig.plist file!")
    }
    // Any errors here indicate that the atlasConfig.plist file has not been formatted properly.
    // Expected key/values:
    //      "appId": "your App Services app ID"
    let data = NSData(contentsOfFile: path)! as Data
    let atlasConfigPropertyList = try! PropertyListSerialization.propertyList(from: data, format: nil) as! [String: Any]
    let _appId = atlasConfigPropertyList["appId"]! as! String
    let _baseUrl = atlasConfigPropertyList["baseUrl"]! as! String
    let _localAppVersion = atlasConfigPropertyList["localAppVersion"]! as! String
    let _apiKey = atlasConfigPropertyList["apiKey"]! as! String
    return DrivingLicenceAppConfig(appId: _appId, baseUrl: _baseUrl , localAppVersion: _localAppVersion , apiKey: _apiKey)
}
