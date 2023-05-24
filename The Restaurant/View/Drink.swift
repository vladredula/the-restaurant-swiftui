//
//  Drink.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/19.
//

import SwiftUI

struct Drink: View {
    @State var filteredItems: [Item] = []
    @StateObject var drinkModel = MenuModel()
    
    @State var selectedCategory = "cckt"
    
    private var items: [Item] {
        filteredItems.isEmpty ? drinkModel.items : filteredItems
    }
    
    private var subCategories: [String] {
        drinkModel.getSubCategories(abbr: selectedCategory)
    }
    
    var body: some View {
        
        ZStack {
                
            Text("drink")
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
                    
                    Text("drinkMenu")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    CategoryView(
                            categories: drinkModel.categories,
                            selectedCategory: $selectedCategory)
                        .onChange(of: selectedCategory, perform: filterItems)
                    
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        ScrollViewReader { itemProxy in
                            
                            ForEach(subCategories, id: \.self) { subcat in
                                
                                VStack (spacing: 2) {
                                    
                                    Text(LocalizedStringKey(subcat))
                                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.vertical, 8)
                                        .foregroundColor(.white)
                                        .background(Color("Nav"))
                                    
                                    ForEach(items.filter{ filtered in filtered.subcategory.contains(subcat)}) { item in
                                            DrinkItemView(drink: item)
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
                try await drinkModel.fetchDrinkItems()
            } catch {
                print(error)
            }
        }
    }
    
    private func filterItems(abbr: String) {
        filteredItems = drinkModel.filterItems(abbr: abbr)
    }
}

struct Drink_Previews: PreviewProvider {
    static var previews: some View {
        Drink()
    }
}
