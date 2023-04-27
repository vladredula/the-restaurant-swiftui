//
//  CustomTabView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/08.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var tabSelection: Int
    
    let tabBarItems: [(image: String, imageActive: String, title: LocalizedStringKey)] = [
        ("house", "house.fill", "home"),
        ("fork.knife", "fork.knife", "food"),
        ("wineglass", "wineglass.fill", "drink"),
        ("gearshape", "gearshape.fill", "setting")
    ]
    
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                Button {
                    tabSelection = index + 1
                } label: {
                    VStack(spacing:0) {
                        
                        if index + 1 == tabSelection {
                            Image(systemName: tabBarItems[index].imageActive)
                        } else {
                            Image(systemName: tabBarItems[index].image)
                        }
                        
                        Text(tabBarItems[index].title)
                        
                        
                        Rectangle()
                            .frame(height: 3)
                            .foregroundColor(index + 1 == tabSelection ? .accentColor : .clear)
                            .offset(y: 5)
                    }
                    .foregroundColor(index + 1 == tabSelection ? .accentColor : .gray)
                }
            }
        }
        .frame(height: 50)
        .offset(y: 5)
        .background(
            Color.black.ignoresSafeArea(edges: .bottom))
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(tabSelection: .constant(1))
            .previewLayout(.sizeThatFits)
    }
}
