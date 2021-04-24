//
//  BikeRentalZoneModel.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 19.04.2021.
//

import Foundation

struct BRZone: Codable, Equatable {
  var number: Int
  var zoneID: String
  var isActive: Int
  var rentable: String
  var rentedCount: String
  var lat: String
  var lon: String
  var lastCheck: String
  var name: String

  private enum CodingKeys: String, CodingKey {
    case number      = "guid"
    case zoneID      = "istasyon_no"
    case isActive    = "aktif"
    case rentable    = "bos"
    case rentedCount = "dolu"
    case lastCheck   = "sonBaglanti"
    case name         = "adi"
    case lon, lat
  }
}

struct ZoneResult: Decodable {
  var serviceCode: Int
  var serviceDesc: String
  var dataList: [BRZone]
}
