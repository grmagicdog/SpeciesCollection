//
//  UserData.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var setTime = Time()
    @Published var remainedTime = Time()
    @Published var speciess = speciesData
    @Published var status = speciesStatus
    @Published var showFavoritesOnly = false
    @Published var tabSelection = 0
}
