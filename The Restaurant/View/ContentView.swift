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
//                WebView(url: URL(string: "http://therestaurant.ap-northeast-1.elasticbeanstalk.com/")!)
                    .tag(1)
                Food()
//                WebView(url: URL(string: "http://therestaurant.ap-northeast-1.elasticbeanstalk.com/food")!)
                    .tag(2)
                Drink()
//                WebView(url: URL(string: "http://therestaurant.ap-northeast-1.elasticbeanstalk.com/drink")!)
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
