//
//  ContentView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/08.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDark = false
    @State private var tabSelection: Int = 1
    
    var body: some View {
        
        VStack {
            
            Text("The Restaurant")
                .font(.custom("Lobster-Regular", size: 30))
            
            TabView(selection: $tabSelection) {
                
                Home(moveTo: $tabSelection)
                    .tag(1)
                Food()
                    .tag(2)
                Drink()
                    .tag(3)
                ConfigView()
                    .tag(4)
            }
            .overlay(alignment: .bottom) {
                CustomTabView(tabSelection: $tabSelection)
            }
        }
        .background(Color("Background").ignoresSafeArea())
        .preferredColorScheme(isDark ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
