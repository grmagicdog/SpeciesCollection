//
//  WebView.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/17.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView(frame: .zero)
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: self.url)
        uiView.load(request)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: speciesData[0].url)
    }
}
