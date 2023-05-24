//
//  ItemViewModel.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/27.
//

import Foundation

@MainActor
class MenuModel: ObservableObject {
    
    let client = HTTPClient()
    
    @Published var items: [Item] = []
    @Published var categories: [Category] = []
    
    func fetchFoodItems() async throws {
        items = try await client.fetchItems(url: URL.foodItems)
        categories = try await client.fetchCategories(url: URL.foodCategories)
    }
    
    func fetchDrinkItems() async throws {
        items = try await client.fetchItems(url: URL.drinkItems)
        categories = try await client.fetchCategories(url: URL.drinkCategories)
    }
    
    func filterItems (abbr: String) -> [Item] {
        return items.filter { item in
            item.category.contains(abbr)
        }
    }
    
    func getSubCategories (abbr: String) -> [String] {
        return Array(Set(items.filter { item in
                item.category.contains(abbr)
            }
            .map { $0.subcategory }))
            .sorted()
    }
}
