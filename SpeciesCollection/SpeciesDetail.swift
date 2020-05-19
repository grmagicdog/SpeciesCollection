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
    
    var speciesIndex: Int {
        userData.speciess.firstIndex(where: {
            $0.id == species.id
        })!
    }

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
                            self.userData.speciess[self.speciesIndex].isFavorite.toggle()
                            update(self.userData.speciess, to: "speciesData.json")
                        }) {
                            if self.userData.speciess[self.speciesIndex].isFavorite {
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
                        .padding(.bottom)
                   
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
                                .padding(.bottom, 12)
                                .font(.custom("Baskerville", size: 16))
                            )
                        } else {
                            return AnyView(
                                Text("　" + text)
                                .padding(.bottom, 12)
                                .font(.custom("Baskerville", size: 20))
                                .lineSpacing(12))
                        }
                    }
                    
                    NavigationLink(destination: SpeciesWiki(species: species)) {
                        Spacer()
                        Text("もっと詳しく")
                    }
                    .padding(.vertical)
                    Spacer()
                        
                    
                    
                        
                }
                .padding()
            }
            
        }
        .navigationBarTitle(Text(species.jpnName), displayMode: .inline)
    }
}

struct SpeciesDetail_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesDetail(species: speciesData[0])
            .environmentObject(UserData())
    }
}
