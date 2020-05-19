//
//  Species.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Species: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var binomen: String
    var jpnName: String
    var family: String
    var genus: String
    var iucnCatagory: String
    var isUnlocked: Bool
    var isFavorite: Bool
    var detailText: [String]
    var url: URL {
        let urlString = "https://ja.wikipedia.org/wiki/\(self.jpnName)"
        return URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
}

extension Species {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
