//
//  BRZoneDetailVM.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 21.04.2021.
//

import Foundation

class BRZoneDetailVM: BRZoneDetailProtocol {
  weak var delegate: BRZoneDetailVMDelegate?
  var zone: BRZone?

  init(zone: BRZone?) {
    self.zone = zone
  }
  func load() {
    delegate?.show(zone: zone)
  }

}
