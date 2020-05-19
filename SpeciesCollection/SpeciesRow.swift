//
//  SpeciesRow.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI

struct SpeciesRow: View {
    var species: Species
    var body: some View {
        HStack {
            species.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipped()
            Text(species.jpnName)
            Spacer()
            if species.isFavorite {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct SpeciesRow_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesRow(species: speciesData[1])
    }
}
