//
//  SpeciesRow.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI

struct SpeciesRow: View {
    @EnvironmentObject var userData: UserData
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
            if userData.status[species.statusIndex].isFavorite {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            } else if userData.status[species.statusIndex].isNew {
                Text("新規")
                    .foregroundColor(Color.blue)
                    .font(.custom("HelveticaNeue-Medium", size: 18))
            }
        }
    }
}

struct SpeciesRow_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesRow(species: speciesData[1])
            .environmentObject(UserData())
    }
}
