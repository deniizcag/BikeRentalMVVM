//
//  String+Extensions.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 21.04.2021.
//

import Foundation

extension String {

  func toDate() -> String {
    var dropCount = 0
    let stringData = self
    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale // save locale temporarily
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    if stringData.count == 22 {
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
      dropCount = 4
    } else if stringData.count == 21 {
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sZ"
      dropCount = 3
    } else if stringData.count < 21 {
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:Z"
      dropCount = 2
    } else {
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sssZ"
      dropCount = 5
    }
    var test = stringData.dropLast(dropCount)
    test += "Z"
    let date = dateFormatter.date(from: String(test))!
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    dateFormatter.locale = tempLocale // reset the locale
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    let dateString = dateFormatter.string(from: date)
    return dateString
  }

}
