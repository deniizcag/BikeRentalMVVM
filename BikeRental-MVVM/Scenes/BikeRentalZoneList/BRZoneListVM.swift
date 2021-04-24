//
//  BikeRentalZoneListVM.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 19.04.2021.
//

import Foundation

final class BRZoneListVM: BRZoneListVMProtocol {
  weak var delegate: BRZoneListVMDelegate?
  var zones: [BRZone]?
  var service: ZoneListServiceProtocol
  var selectedZone: BRZone?
  init(service: ZoneListServiceProtocol) {
    self.service = service
  }

  func fetch() {
    notify(.setLoading(true))
    service.fetchZoneList { (result) in
      self.notify(.setLoading(false))
      switch result {
      case .success(let fetchedZones):
        self.notify(.updateTitle("Bike Rental Zones"))
        self.zones = fetchedZones
        self.notify(.showZoneList(self.zones!))
      case .failure(let error):
        print(error)
      }
    }
  }

  func selectZone(at index: Int) {
    let zone = zones?[index]
    selectedZone = zone
    delegate?.navigateToDetailScreen(for: zone)
  }

  func notify(_ outputs: BRZoneListVMOutput) {
    delegate?.handleViewModelOutputs(outputs)

  }

}
