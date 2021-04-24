//
//  ZoneListBuilder.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 21.04.2021.
//

import Foundation

final class BRZoneListBuilder {

    static func make() -> BRZoneListVC {
        let viewController = BRZoneListVC()
        viewController.viewModel = BRZoneListVM(service: app.service)
        return viewController
    }
}
