//
//  ContentView.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/15.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
 
    var body: some View {
        TabView(selection: $userData.tabSelection){
            ConcentrateView()
                .tabItem {
                    VStack {
                        Image(systemName: "clock")
                        Text("集中")
                    }
                }
                .tag(0)
            CollectionView()
                .tabItem {
                    Image(systemName: "cube.box")
                    Text("コレクション")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}
