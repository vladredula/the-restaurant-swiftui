//
//  Food.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/19.
//

import SwiftUI

struct Items: Hashable, Codable {
    let items: [Item]
}

struct Item: Identifiable, Hashable, Codable {
    var id: String
    var name: String
    var tname: String
    var category: String
    var subcategory: String
    var price: String
    var imgUrl: String
    var itemType: String
}

class ItemModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var subcatecories: [String] = []
    var type: String
    
    init(type: String) {
        self.type = type
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
        return self.items.sorted { $0.id < $1.id }
    }
    
    func getSubCat () -> [String] {
        return Array(Set(self.items.map { $0.subcategory }))
    }
}
