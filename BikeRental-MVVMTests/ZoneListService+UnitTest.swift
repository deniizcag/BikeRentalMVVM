//
//  ZoneListService+UnitTest.swift
//  BikeRental-MVVMTests
//
//  Created by DenizCagilligecit on 23.04.2021.
//

import XCTest
@testable import BikeRental_MVVM
class ZoneListService_UnitTest: XCTestCase {

  var service: ZoneListService!

  override func setUp() {
    super.setUp()
  }

  func testReturnZones() {
      let e = expectation(description: "Thingy")

    service = ZoneListService()
    service.fetchZoneList(completed: { (result) in
      switch result {
      case .success:
        e.fulfill()
      case .failure:
        break
      }
    })

      waitForExpectations(timeout: 5.0, handler: nil)
  }
  func testReturnError() {
      let e = expectation(description: "Thingy")

    service = ZoneListService()
    service.url = "testFailurl"
    service.fetchZoneList(completed: { (result) in
      switch result {
      case .success:
        break
      case .failure:
        e.fulfill()
      }
    })

      waitForExpectations(timeout: 5.0, handler: nil)
  }

}
