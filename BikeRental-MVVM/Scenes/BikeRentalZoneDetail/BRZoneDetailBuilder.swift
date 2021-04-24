//
//  BRZoneDetailBuilder.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 21.04.2021.
//

import Foundation

final class BRZoneDetailBuilder {
  static func make(zone: BRZone?) -> BikeRentalZoneDetailVC {
    let viewController = BikeRentalZoneDetailVC()
    viewController.viewModel = BRZoneDetailVM(zone: zone)
    return viewController
  }
}
