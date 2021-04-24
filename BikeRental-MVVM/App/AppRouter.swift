//
//  AppRouter.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 21.04.2021.
//

import UIKit

final class AppRouter {
    let window: UIWindow
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    func start() {
      let viewController = BRZoneListBuilder.make()
        viewController.viewModel =  BRZoneListVM(service: app.service)
        let rootController = UINavigationController(rootViewController: viewController)
        window.rootViewController = rootController
        window.makeKeyAndVisible()
    }
}
