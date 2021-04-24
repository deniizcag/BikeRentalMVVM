//
//  AppDelegate.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 19.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    app.router.start()
    return true
  }

}
