//
//  SpeciesDetail.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/17.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI

struct SpeciesDetail: View {
    @EnvironmentObject var userData: UserData
    var species: Species

    var body: some View {
        ScrollView {
            VStack {
                species.image
                    .resizable()
                    .scaledToFit()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(species.family)
                            .foregroundColor(.blue)
                            
                        Text(species.genus)
                            .foregroundColor(.blue)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(species.jpnName)
                            .font(.custom("MarketFelt-Wide", size: 34))
                            
                        Button(action: {
                            self.userData.status[self.species.statusIndex].isFavorite.toggle()
                            update(self.userData.status, to: "speciesStatus.json")
                        }) {
                            if self.userData.status[self.species.statusIndex].isFavorite {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .imageScale(.large)
                            }
                            else {
                                Image(systemName: "star")
                                    .foregroundColor(.gray)
                                    .imageScale(.large)
                            }
                        }
                    }
                    
                    HStack {
                        Text(species.binomen)
                            .font(.custom("TimesNewRomanPS-ItalicMT", size: 20))
                        
                        Spacer()
                        
                        Text(species.name)
                            .font(.custom("TimesNewRomanPSMT", size: 20))
                    }
                    
                    Text("保全状況：\(species.iucnCatagory)")
                        .foregroundColor(.red)
                        .padding(.top)
                    
                    Image("iucnCatagory")
                        .resizable()
                        .scaledToFit()
                   
                    ForEach(self.species.detailText, id: \.self) { text -> AnyView in
                        if text.match(pattern: .image) {
                            return AnyView(
                                Image("\(self.species.imageName)_\(text.strip())")
                                .resizable()
                                .scaledToFit()
                            )
                        } else if text.match(pattern: .caption){
                            return AnyView(
                                Text(text.strip())
                                .foregroundColor(Color.gray)
                                .font(.custom("Baskerville", size: 16))
                            )
                        } else {
                            return AnyView(
                                Text("　" + text)
                                .padding(.top, 18)
                                .font(.custom("Baskerville", size: 20))
                                .lineSpacing(12)
                                .fixedSize(horizontal: false, vertical: true)
                            )
                        }
                    }
                    
                    NavigationLink(destination: SpeciesWiki(species: species)) {
                        Spacer()
                        
                        Text("もっと詳しく")
                    }
                    .padding(.vertical)
                }
                .padding()
            }
        }
        .navigationBarTitle(Text(species.jpnName), displayMode: .inline)
        .onAppear {
            if self.userData.status[self.species.statusIndex].isNew {
                self.userData.status[self.species.statusIndex].isNew = false
                update(self.userData.status, to: "speciesStatus.json")
            }
        }
    }
}

struct SpeciesDetail_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesDetail(species: speciesData[0])
            .environmentObject(UserData())
    }
}
