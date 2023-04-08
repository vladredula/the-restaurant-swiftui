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
            Text("Tab Content 1")
                .tag(1)
            Text("Tab Content 2")
                .tag(2)
            Text("Tab Content 3")
                .tag(3)
            Text("Tab Content 4")
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
