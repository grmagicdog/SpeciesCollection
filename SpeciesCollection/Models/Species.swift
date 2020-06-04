//
//  Species.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI
import CoreLocation

//基本データの要素
struct Species: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var binomen: String
    var jpnName: String
    var family: String
    var genus: String
    var iucnCatagory: String
    var detailText: [String]
    var url: URL {
        let urlString = "https://ja.wikipedia.org/wiki/\(self.jpnName)"
        return URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
}

//状態データの要素
struct Status: Hashable, Codable, Identifiable {
    var id: Int
    var isUnlocked: Bool
    var isFavorite: Bool
    var isNew = true
}

//基本データの拡張要素
extension Species {
    var image: Image {
        Image(imageName)
    }
    var statusIndex: Int {
        getIndex(for: .status, id: self.id)
    }
}

//ロックされている生物IDの配列
var idLocked: [Int] {
    var ids = [Int]()
    for status in speciesStatus {
        if !status.isUnlocked {
            ids.append(status.id)
        }
    }
    return ids
}
