//
//  SpeciesWiki.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/17.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI

struct SpeciesWiki: View {
    var species: Species
    
    var body: some View {
        WebView(url: species.url)
    }
}

struct SpeciesWiki_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesWiki(species: speciesData[0])
    }
}
