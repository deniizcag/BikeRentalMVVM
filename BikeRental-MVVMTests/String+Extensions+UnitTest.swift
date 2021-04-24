//
//  String+Extensions+UnitTest.swift
//  BikeRental-MVVMTests
//
//  Created by DenizCagilligecit on 23.04.2021.
//

import XCTest
@testable import BikeRental_MVVM
class String_Extensions_UnitTest: XCTestCase {

  override  func setUp() {
    super.setUp()
  }

  func testStringDateExtension() {

    /// : Given
    let dateString23Letters = "2021-04-17T23:49:17.323"
    let dateString22Letters = "2021-04-14T14:22:47.59"
    let dateString21Letters = "2021-04-17T23:47:07.3"
    let dateString20Letters = "2021-01-11T09:03:07"

    /// : When
    let convertedString23 = dateString23Letters.toDate()
    let convertedString22 = dateString22Letters.toDate()
    let convertedString21 = dateString21Letters.toDate()
    let convertedString20 = dateString20Letters.toDate()

    /// : Then
    XCTAssertEqual(convertedString23, "17/04/2021 23:49")
    XCTAssertEqual(convertedString22, "14/04/2021 14:22")
    XCTAssertEqual(convertedString21, "17/04/2021 23:47")
    XCTAssertEqual(convertedString20, "11/01/2021 09:03")

  }

}
