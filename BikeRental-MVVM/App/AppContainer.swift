//
//  AppContainer.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 21.04.2021.
//

import Foundation

let app = AppContainer()

final class AppContainer {

    let router = AppRouter()
    let service =  ZoneListService()
}
