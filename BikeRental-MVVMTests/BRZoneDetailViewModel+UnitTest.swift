//
//  BRZoneDetailViewModel+UnitTest.swift
//  BikeRental-MVVMTests
//
//  Created by DenizCagilligecit on 23.04.2021.
//

import XCTest
@testable import BikeRental_MVVM
class BRZoneDetailViewModel_UnitTest: XCTestCase {

  var sut: BRZoneDetailVM!

  override func setUp() {
    super.setUp()

  }

  func testInitialization() {
    /// : Given
    let zone = BRZone(number: 1, zoneID: "test", isActive: 1, rentable: "5", rentedCount: "10", lat: "40.12", lon: "38.11", lastCheck: "2021-11-23'T'14:33:10", name: "Test Zone")

    /// : When
    sut = BRZoneDetailVM(zone: zone)

    /// : Then
    XCTAssertNotNil(sut.zone)
  }
  func testZoneDelegate() {
    /// : Given
    let zone = BRZone(number: 1, zoneID: "test", isActive: 1, rentable: "5", rentedCount: "10", lat: "40.12", lon: "38.11", lastCheck: "2021-11-23'T'14:33:10", name: "Test Zone")
    let mockDelegate = MockZoneDetailVMDelegate()

    /// : When
    sut = BRZoneDetailVM(zone: zone)
    sut.delegate = mockDelegate
    sut.load()

    // : Then
    XCTAssertEqual(sut.zone, mockDelegate.selectedZone)

  }

}

class MockZoneDetailVMDelegate: BRZoneDetailVMDelegate {

  var selectedZone: BRZone?
  func show(zone: BRZone?) {
    selectedZone = zone
  }

}
