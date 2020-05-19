//
//  UserData.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI
import Combine

struct Time {
    var timeUp = false
    var hour: Int = 0 {
        didSet {
            if hour < 0 {
                timeUp = true
                hour = 0
                minute = 0
                second = 0
            }
        }
    }
    var minute: Int = 30 {
        didSet {
            if minute < 0 {
                minute = 59
                hour -= 1
            }
        }
    }
    var second: Int = 0 {
        didSet {
            if second < 0 {
                second = 59
                minute -= 1
            }
        }
    }
}

final class UserData: ObservableObject {
    @Published var setTime = Time()
    @Published var remainedTime = Time()
    @Published var speciess = speciesData
    @Published var showFavoritesOnly = false
}
