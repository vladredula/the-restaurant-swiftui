//
//  CategoryView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/27.
//

import SwiftUI

struct CategoryView: View {
    var categories: [Category]
    @Binding var selectedCategory: String
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false, content: {
            
            ScrollViewReader { categoryProxy in
                
                HStack (spacing: 0) {
                    
                    ForEach(categories) { category in
                        
                        Text(LocalizedStringKey(category.name))
                            .textCase(.uppercase)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 15)
                            .frame(minWidth: 125)
                            .background(selectedCategory == category.abbr ? Color.accentColor : Color("Nav"))
                            .id(category.abbr)
                            .onTapGesture {
                                selectedCategory = category.abbr
                                withAnimation(.spring()) {
                                    categoryProxy.scrollTo(selectedCategory, anchor: .leading)
                                }
                            }
                    }
                }
                .font(.title3)
                .foregroundColor(Color.white)
            }
        })
        .background(Color("Nav"))
    }
}


struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        Food()
    }
}
