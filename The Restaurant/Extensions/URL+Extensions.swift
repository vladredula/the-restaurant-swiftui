//
//  URL+Extensions.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/30.
//

import Foundation

extension URL {
    
    static var development: URL {
        URL(string: "https://ya398c21fc.execute-api.ap-northeast-1.amazonaws.com/prod/")!
    }
    
    static var production: URL {
        URL(string: "https://ya398c21fc.execute-api.ap-northeast-1.amazonaws.com/prod/")!
    }
    
    static var `default`: URL {
        #if DEBUG
            return development
        #else
            return production
        #endif
    }
    
    static var foodItems: URL {
        URL(string: "item/food", relativeTo: Self.default)!
    }
    
    static var drinkItems: URL {
        URL(string: "item/drink", relativeTo: Self.default)!
    }
    
    static var foodCategories: URL {
        URL(string: "category/food", relativeTo: Self.default)!
    }
    
    static var drinkCategories: URL {
        URL(string: "category/drink", relativeTo: Self.default)!
    }
}
