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
    
    //動的残り表示テキスト
    var remainText: Text {
        if idLocked.count > 0 {
            return Text("入手可能な生物：残り\(idLocked.count)種")
        } else {
            return Text("全生物を入手しています")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                //お気に入りのみ表示トグル
                Toggle(isOn: $userData.showFavoritesOnly) { Text("お気に入りのみ")}
                
                //生物項目の表示
                ForEach(userData.speciess) { species in
                    if self.userData.status[species.statusIndex].isUnlocked &&
                        (!self.userData.showFavoritesOnly || self.userData.status[species.statusIndex].isFavorite) {
                        //詳細画面へ遷移
                        NavigationLink(destination: SpeciesDetail(species: species)) {
                            SpeciesRow(species: species)
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    //残り表示
                    remainText
                        .foregroundColor(.gray)
                        .font(.callout)
                    
                    Spacer()
                }
            }
        //ナビゲーションタイトル
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
