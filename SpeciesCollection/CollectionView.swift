//
//  CollectionView.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var userData: UserData
        
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $userData.showFavoritesOnly) { Text("お気に入りのみ")}
                
                ForEach(userData.speciess) { species in
                    if self.userData.status[species.statusIndex].isUnlocked &&
                        (!self.userData.showFavoritesOnly || self.userData.status[species.statusIndex].isFavorite) {
                        NavigationLink(destination: SpeciesDetail(species: species)) {
                            SpeciesRow(species: species)
                        }
                    }
                }
                
            }
        .navigationBarTitle(Text("コレクション"))
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
            .environmentObject(UserData())
    }
}
