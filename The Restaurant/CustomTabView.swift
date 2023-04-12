//
//  CustomTabView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/08.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    
    let tabBarItems: [(image: String, imageActive: String, title: LocalizedStringKey)] = [
        ("house", "house.fill", "home"),
        ("fork.knife", "fork.knife", "food"),
        ("wineglass", "wineglass.fill", "drink"),
        ("globe.asia.australia", "globe.asia.australia.fill", "lang")
    ]
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 70)
                .foregroundColor(Color(.black))
            HStack {
                ForEach(0..<4) { index in
                    Button {
                        tabSelection = index + 1
                    } label: {
                        VStack(spacing: 8) {
                            Spacer()
                            
                            if index + 1 == tabSelection {
                                Image(systemName: tabBarItems[index].imageActive)
                            } else {
                                Image(systemName: tabBarItems[index].image)
                            }
                            
                            Text(tabBarItems[index].title)
                            
                            if index + 1 == tabSelection {
                                Rectangle()
                                    .frame(height: 8)
                                    .foregroundColor(.white)
                                    .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                                    .offset(y: 3)
                            } else {
                                Rectangle()
                                    .frame(height: 8)
                                    .foregroundColor(.clear)
                                    .offset(y: 3)
                            }
                        }
                        .foregroundColor(index + 1 == tabSelection ? .white : .gray)
                    }
                }
            }
            .frame(height: 70)
            .clipShape(Rectangle())
            .background(
                Color.black.ignoresSafeArea(edges: .bottom))
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(tabSelection: .constant(1))
            .previewLayout(.sizeThatFits)
    }
}
