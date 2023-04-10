//
//  HomeView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/09.
//

import SwiftUI
import WebKit

struct WebView:UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
