//
//  BRZoneListDetailVC+UnitTest.swift
//  BikeRental-MVVMTests
//
//  Created by DenizCagilligecit on 23.04.2021.
//

import XCTest
@testable import BikeRental_MVVM

class BRZoneListDetailVC_UnitTest: XCTestCase {

  var sut: BikeRentalZoneDetailVC?

  override func setUp() {

    sut = BikeRentalZoneDetailVC()
    sut?.loadViewIfNeeded()

  }

  func testSetViewModel() {
    /// : Given
    let zone = BRZone(number: 1, zoneID: "test", isActive: 1, rentable: "5", rentedCount: "10", lat: "40.12", lon: "38.11", lastCheck: "2021-04-17T23:49:17.323", name: "Test Zone")
    let viewModel = BRZoneDetailVM(zone: zone)

    /// : When
    sut?.viewModel = viewModel

    /// : Then
    XCTAssertNotNil(sut?.viewModel)

  }
  func testUpdateView() {
    /// : Given
    let zone = BRZone(number: 1, zoneID: "test", isActive: 1, rentable: "5", rentedCount: "10", lat: "40.12", lon: "38.11", lastCheck: "2021-04-17T23:49:17.323", name: "Test Zone")
    let viewModel = BRZoneDetailVM(zone: zone)

    /// : When
    sut?.viewModel = viewModel
    viewModel.load()

    /// : Then
    XCTAssertEqual(zone.name, sut?.zoneNameLabel.text)

  }

}
