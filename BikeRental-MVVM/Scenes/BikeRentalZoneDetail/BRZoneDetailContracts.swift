//
//  BRZoneDetailContracts.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 21.04.2021.
//

import UIKit

protocol BRZoneDetailProtocol {
  func load()
  var delegate: BRZoneDetailVMDelegate? {get set}
}

protocol BRZoneDetailVMDelegate: class {
  func show(zone: BRZone?)
}
