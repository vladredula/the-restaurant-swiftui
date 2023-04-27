//
//  ItemViewModel.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/27.
//

import SwiftUI

class ItemViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var subcatecories: [String] = []
    var type: String
    
    init(type: String) {
        self.type = type
        fetch()
    }
    
    func fetch() {
        guard let url = URL(string: "https://ya398c21fc.execute-api.ap-northeast-1.amazonaws.com/prod/item/\(self.type)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            // convert to JSON
            do {
                let items = try JSONDecoder().decode(Items.self, from: data)
                self.items = items.items
            }
            catch {
                print("Failed to decode: \(error)")
            }
        }
            
        task.resume()
    }
    
    func sortedItems () -> [Item] {
        return items.sorted { $0.id < $1.id }
    }
    
    func filterItems (abbr: String) -> [Item] {
        return sortedItems().filter { item in
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
