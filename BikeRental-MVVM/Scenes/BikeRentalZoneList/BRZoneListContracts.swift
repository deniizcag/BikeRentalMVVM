//
//  BikeRentalZoneListContracts.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 19.04.2021.
//

import Foundation

protocol BRZoneListVMProtocol {
  var delegate: BRZoneListVMDelegate? {get set}
  func fetch()
  func selectZone(at index: Int)
}
enum BRZoneListVMOutput {
  case setLoading(Bool)
  case showZoneList([BRZone])
  case updateTitle(String)
}
protocol BRZoneListVMDelegate: class {
  func handleViewModelOutputs(_ output: BRZoneListVMOutput)
  func navigateToDetailScreen(for zone: BRZone?)
}
