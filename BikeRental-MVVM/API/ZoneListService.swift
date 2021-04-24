//
//  ZoneListService.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 19.04.2021.
//

import Foundation
import Alamofire

protocol ZoneListServiceProtocol {
  func fetchZoneList(completed: @escaping (Result<[BRZone], BRError>) -> Void)
}
final class ZoneListService: ZoneListServiceProtocol {
  var url = "https://api.ibb.gov.tr/ispark-bike/GetAllStationStatus"

  func fetchZoneList(completed: @escaping (Result<[BRZone], BRError>) -> Void) {
    AF.request(url, method: .get, parameters: nil).responseJSON { (response) in
      switch response.result {
      case .success:
        do {
          let result = try JSONDecoder().decode(ZoneResult.self, from: response.data!)
          completed(.success(result.dataList))
        } catch {
          completed(.failure(.parsingError))
        }
      case .failure(let error):
        print(error)
        completed(.failure(.AFError))
      }
    }
  }
}
enum BRError: Error {
  case emptyData
  case parsingError
  case AFError
  case networkError
}
