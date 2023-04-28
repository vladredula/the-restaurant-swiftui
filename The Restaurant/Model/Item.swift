//
//  Food.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/19.
//

import SwiftUI

struct Items: Codable {
    let items: [Item]
}

struct Item: Identifiable, Codable {
    var id: Int
    var name: String
    var tname: String
    var category: String
    var subcategory: String
    var price: String
    var imgUrl: String
    var itemType: String
}
