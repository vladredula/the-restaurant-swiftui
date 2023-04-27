//
//  Category.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/19.
//

import SwiftUI

struct Categories: Codable {
    let categories: [Category]
}

struct Category: Identifiable, Codable {
    var id: Int
    var name: String
    var abbr: String
    var imgUrl: String
    var itemType: String
}
