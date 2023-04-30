//
//  HTTPClient.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/30.
//

import Foundation

class HTTPClient {
    
    func fetchItems(url: URL) async throws -> [Item] {
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let items = try JSONDecoder().decode(Items.self, from: data)
        
        return items.items.sorted { $0.id < $1.id }
    }
    
    func fetchCategories(url: URL) async throws -> [Category] {
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let categories = try JSONDecoder().decode(Categories.self, from: data)
        
        return categories.categories.sorted { $0.id < $1.id }
    }
}
