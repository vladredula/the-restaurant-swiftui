//
//  Food.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/19.
//

import SwiftUI

struct Food: View {
    @State var filteredItems: [Item] = []
    @StateObject var foodModel = MenuModel()
    
    @State var selectedCategory = "appt"
    
    private var items: [Item] {
        filteredItems.isEmpty ? foodModel.items : filteredItems
    }
    
    private var subCategories: [String] {
        foodModel.getSubCategories(abbr: selectedCategory)
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
            
            if items.isEmpty {
                ProgressView()
            } else {
                
                VStack(spacing: 15) {
                    
                    Text("foodMenu")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    CategoryView(
                            categories: foodModel.categories,
                            selectedCategory: $selectedCategory)
                        .onChange(of: selectedCategory, perform: filterItems)
                        
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        ScrollViewReader { itemProxy in
                            
                            ForEach(subCategories, id: \.self) { subcat in
                                
                                VStack {
                                    
                                    Text(LocalizedStringKey(subcat))
                                        .textCase(.uppercase)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.vertical, 8)
                                        .foregroundColor(.white)
                                        .background(Color.accentColor)
                                    
                                    ForEach(
                                        items.filter{ filtered in filtered.subcategory.contains(subcat)}) { item in
                                            FoodItemView(food: item)
                                                .padding(.vertical, 5)
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
                }
            }
        }
        .frame(maxWidth:getRect().width)
        .background(Color("Background").ignoresSafeArea())
        .task {
            do {
                try await foodModel.fetchFoodItems()
            } catch {
                print(error)
            }
        }
    }
    
    private func filterItems(abbr: String) {
        filteredItems = foodModel.filterItems(abbr: abbr)
    }
}

struct Food_Previews: PreviewProvider {
    static var previews: some View {
        Food()
    }
}
