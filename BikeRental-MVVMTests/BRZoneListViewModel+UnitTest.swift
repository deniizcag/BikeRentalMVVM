//
//  BRZoneListViewModel+UnitTest.swift
//  BikeRental-MVVMTests
//
//  Created by DenizCagilligecit on 22.04.2021.
//

import XCTest
@testable import BikeRental_MVVM
class BRZoneListViewModel_UnitTest: XCTestCase {

  var mockApiService: MockApiService!
  var sut: BRZoneListVM!
  var temperature: Double?
  var expectation: XCTestExpectation?

  override func setUp() {
    super.setUp()
    mockApiService = MockApiService()
    sut = BRZoneListVM(service: mockApiService)

  }
  override func tearDown() {
    super.tearDown()
    mockApiService = nil
    sut = nil
  }

  func testFetchSuccess() {
    /// Given:

    /// When:
    sut?.fetch()
    mockApiService.fetchSuccess()

    // : Then
    XCTAssertEqual(sut?.zones?.count, 0)
  }
  func testFetchError() {
    /// Given:

    /// When:
    sut?.fetch()
    mockApiService.fetchFail(error: .networkError)

    // : Then
    XCTAssertNil(sut?.zones)

  }
  func testSelectZone() {
    /// Given:
    let zone = BRZone(number: 1, zoneID: "test", isActive: 1, rentable: "5", rentedCount: "10", lat: "40.12", lon: "38.11", lastCheck: "2021-11-23'T'14:33:10", name: "Test Zone")
    mockApiService.zones.append(zone)

    /// When:
    sut?.fetch()
    mockApiService.fetchSuccess()
    sut?.selectZone(at: 0)

    /// Then:
    XCTAssertEqual(sut.zones?.first, zone)

  }
  func testselectZoneWithDelegate() {
    /// Given:
    let zone = BRZone(number: 1, zoneID: "test", isActive: 1, rentable: "5", rentedCount: "10", lat: "40.12", lon: "38.11", lastCheck: "2021-11-23'T'14:33:10", name: "Test Zone")
    let mockDelegate = MockZoneListVMDelegate(testCase: self)
    mockApiService.zones.append(zone)

    /// When:
    sut?.fetch()
    mockApiService.fetchSuccess()
    sut.delegate = mockDelegate
    mockDelegate.expectRouting()
    sut?.selectZone(at: 0)

    /// : Then
    waitForExpectations(timeout: 1)
    let result = try? XCTUnwrap(mockDelegate.zone) // 3
    let vc = try? XCTUnwrap(mockDelegate.selectedVC)

    XCTAssertEqual(zone, result)
    XCTAssertEqual(vc, mockDelegate.navigationController?.topViewController)

  }

  func testHandleDelegateOutput() {
    /// Given:
    let zone = BRZone(number: 1, zoneID: "test", isActive: 1, rentable: "5", rentedCount: "10", lat: "40.12", lon: "38.11", lastCheck: "2021-11-23'T'14:33:10", name: "Test Zone")
    let mockDelegate = MockZoneListVMDelegate(testCase: self)
    mockApiService.zones.append(zone)

    /// When:
    sut?.fetch()
    mockApiService.fetchSuccess()
    sut.delegate = mockDelegate

    mockDelegate.expectTitle()
    mockDelegate.expectisLoading()
    mockDelegate.expectZoneList()

    sut.notify(.setLoading(false))
    sut.notify(.showZoneList(mockApiService.zones))
    sut.notify(.updateTitle("Bike Rental Zones"))

    /// : Then
    waitForExpectations(timeout: 1)
    let title = try? XCTUnwrap(mockDelegate.title)
    let isLoading = try? XCTUnwrap(mockDelegate.isLoading)
    let zones = try? XCTUnwrap(mockDelegate.zoneList)

    XCTAssertEqual(title, "Bike Rental Zones")
    XCTAssertEqual(isLoading, false)
    XCTAssertEqual(zones?[0], zone)

  }
}

class MockZoneListVMDelegate: BRZoneListVMDelegate {
  func handleViewModelOutputs(_ output: BRZoneListVMOutput) {
    switch output {
    case .setLoading(let isLoading):
      if expectationLoading != nil {
        self.isLoading = isLoading
      }
      expectationLoading?.fulfill()
      expectationLoading = nil

    case .showZoneList(let zones):
      if expectationZoneList != nil {
        self.zoneList = zones
      }
      expectationZoneList?.fulfill()
      expectationZoneList = nil

    case .updateTitle(let title):
      if expectationTitle != nil {
        self.title = title
      }
      expectationTitle?.fulfill()
      expectationTitle = nil
    }
  }

  func navigateToDetailScreen(for zone: BRZone?) {
    if expectationRouting != nil {
      self.zone = zone
      self.selectedVC = BRZoneDetailBuilder.make(zone: zone)
      self.navigationController = UINavigationController(rootViewController: selectedVC!)

    }
    expectationRouting?.fulfill()
    expectationRouting = nil
  }

  private var expectationRouting: XCTestExpectation?
  private var expectationLoading: XCTestExpectation?
  private var expectationZoneList: XCTestExpectation?
  private var expectationTitle: XCTestExpectation?
  private let testCase: XCTestCase

  var zone: BRZone?
  var isLoading: Bool?
  var title: String?
  var zoneList: [BRZone]?
  var selectedVC: BikeRentalZoneDetailVC?
  var navigationController: UINavigationController?

  init(testCase: XCTestCase) {
    self.testCase = testCase
  }

  func expectRouting() {
    expectationRouting = testCase.expectation(description: "Expect Routing")
  }
  func expectTitle() {
    expectationTitle = testCase.expectation(description: "Title Error")
  }
  func expectZoneList() {
    expectationZoneList = testCase.expectation(description: "Zone List Error")
  }
  func expectisLoading() {
    expectationLoading = testCase.expectation(description: "isLoading not working")
  }
}

class MockApiService: ZoneListServiceProtocol {
  var completeClosure: ((Result<[BRZone], BRError>) -> Void)!
  var zones = [BRZone]()

  func fetchZoneList(completed: @escaping (Result<[BRZone], BRError>) -> Void) {
    completeClosure = completed
  }

  func fetchSuccess() {
    completeClosure(.success(zones))
  }

  func fetchFail(error: BRError) {
    completeClosure(.failure(error))
  }
}
