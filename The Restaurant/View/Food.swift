//
//  Food.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/19.
//

import SwiftUI

struct Food: View {
    @State var filteredItems: [Item] = []
    @StateObject var foodViewModel = ItemViewModel(type: "food")
    @StateObject var categoryViewModel = CategoryViewModel(type: "food")
    
    @State var selectedCategory = "appt"
    
    private var items: [Item] {
        filteredItems.isEmpty ? foodViewModel.sortedItems() : filteredItems
    }
    
    private var subCategories: [String] {
        foodViewModel.getSubCategories(abbr: selectedCategory)
    }
    
    var body: some View {
        ZStack {
            
            Text("food")
                .font(.system(size: 100))
                .fontWeight(.heavy)
                .textCase(.uppercase)
                .foregroundColor(Color.gray.opacity(0.1))
                .frame(maxHeight: getRect().height, alignment: .top)
                .offset(y:-22)
            
            VStack(spacing: 15) {
                
                Text("foodMenu")
                    .font(.title2)
                    .fontWeight(.bold)
                
                CategoryView(
                        categories: categoryViewModel.sortedItems(),
                        selectedCategory: $selectedCategory)
                    .onChange(of: selectedCategory, perform: filterItems)
                    
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    ScrollViewReader { itemProxy in
                        
                        ForEach(subCategories, id: \.self) { subcat in
                            
                            VStack (spacing: 2) {
                                Text(LocalizedStringKey(subcat))
                                    .textCase(.uppercase)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.vertical, 8)
                                    .foregroundColor(.white)
                                    .background(Color.accentColor)
                                    .padding(.bottom, 10)
                                
                                ForEach(
                                    items.filter{ filtered in
                                        filtered.subcategory.contains(subcat)
                                    }) { item in
                                        FoodItemView(food: item)
                                    }
                            }
                            .id(subcat)
                            .padding(.bottom)
                        }
                        .onChange(of: subCategories) { newValue in
                            withAnimation(.spring()) {
                                itemProxy.scrollTo(newValue.first, anchor: .top)
                            }
                        }
                    }
                })
                .padding(.horizontal)
            }
        }
        .background(Color("Background").ignoresSafeArea())
    }
    
    private func filterItems(abbr: String) {
        filteredItems = foodViewModel.filterItems(abbr: abbr)
    }
}

struct Food_Previews: PreviewProvider {
    static var previews: some View {
        Food()
    }
}
