//
//  Category.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/19.
//

import SwiftUI

struct Categories: Hashable, Codable {
    let categories: [Category]
}

struct Category: Identifiable, Hashable, Codable {
    var id: Int
    var name: String
    var abbr: String
    var imgUrl: String
    var itemType: String
}

class CategoryModel: ObservableObject {
    @Published var categories: [Category] = []
    var type: String
    
    init(type: String) {
        self.type = type
        self.fetch()
    }
    
    func fetch() {
        guard let url = URL(string: "https://ya398c21fc.execute-api.ap-northeast-1.amazonaws.com/prod/category/type/\(self.type)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            // convert to JSON
            do {
                let categories = try JSONDecoder().decode(Categories.self, from: data)
                self.categories = categories.categories
            }
            catch {
                print("Failed to decode: \(error)")
            }
        }
            
        task.resume()
    }
    
    func sortedItems () -> [Category] {
        return self.categories.sorted { $0.id < $1.id }
    }
    
    func getFirstCategory() -> Category {
        return self.categories.min(by: { $0.id < $1.id })!
    }
}
