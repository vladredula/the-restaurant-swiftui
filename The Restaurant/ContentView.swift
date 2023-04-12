//
//  ContentView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/08.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            WebView(url: URL(string: "http://therestaurant.ap-northeast-1.elasticbeanstalk.com/")!)
                .tag(1)
            WebView(url: URL(string: "http://therestaurant.ap-northeast-1.elasticbeanstalk.com/food")!)
                .tag(2)
            WebView(url: URL(string: "http://therestaurant.ap-northeast-1.elasticbeanstalk.com/drink")!)
                .tag(3)
            ConfigView()
                .tag(4)
        }
        .overlay(alignment: .bottom) {
            CustomTabView(tabSelection: $tabSelection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
