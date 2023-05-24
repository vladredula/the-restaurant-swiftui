//
//  The_RestaurantTests.swift
//  The RestaurantTests
//
//  Created by Vlad Redula on 2023/04/08.
//

import XCTest
@testable import The_Restaurant

final class The_RestaurantTests: XCTestCase {

    @MainActor
    func test_filter_items_by_category() {
        let sut = MenuModel()
        
        sut.items = [
            Item(id: 1, name: "item1", tname: "アイテム1", category: "cat1", subcategory: "subCat1", price: "1", imgUrl: "url", itemType: "food"),
            Item(id: 2, name: "item2", tname: "アイテム2", category: "cat1", subcategory: "subCat1", price: "1", imgUrl: "url", itemType: "food"),
            Item(id: 3, name: "item3", tname: "アイテム3", category: "cat2", subcategory: "subCat1", price: "1", imgUrl: "url", itemType: "food"),
            Item(id: 4, name: "item4", tname: "アイテム4", category: "cat3", subcategory: "subCat1", price: "1", imgUrl: "url", itemType: "food"),
            Item(id: 5, name: "item5", tname: "アイテム5", category: "cat2", subcategory: "subCat1", price: "1", imgUrl: "url", itemType: "food")
        ]
        
        let actual = sut.filterItems(abbr: "cat2")
        
        let expected = [
            Item(id: 3, name: "item3", tname: "アイテム3", category: "cat2", subcategory: "subCat1", price: "1", imgUrl: "url", itemType: "food"),
            Item(id: 5, name: "item5", tname: "アイテム5", category: "cat2", subcategory: "subCat1", price: "1", imgUrl: "url", itemType: "food")
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
    @MainActor
    func test_get_subcategories_of_a_category() {
        let sut = MenuModel()
        
        sut.items = [
            Item(id: 1, name: "item1", tname: "アイテム1", category: "cat1", subcategory: "subCat1", price: "1", imgUrl: "url", itemType: "food"),
            Item(id: 2, name: "item2", tname: "アイテム2", category: "cat1", subcategory: "subCat1", price: "1", imgUrl: "url", itemType: "food"),
            Item(id: 3, name: "item3", tname: "アイテム3", category: "cat2", subcategory: "subCat1", price: "1", imgUrl: "url", itemType: "food"),
            Item(id: 4, name: "item4", tname: "アイテム4", category: "cat3", subcategory: "subCat1", price: "1", imgUrl: "url", itemType: "food"),
            Item(id: 5, name: "item5", tname: "アイテム5", category: "cat2", subcategory: "subCat2", price: "1", imgUrl: "url", itemType: "food")
        ]
        
        let actual = sut.getSubCategories(abbr: "cat2")
        
        let expected = [
            "subCat1",
            "subCat2"
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_fetch_food_items_is_not_nil() async {
        let sut = HTTPClient()
        var actual: [Item] = []
        
        do {
            actual = try await sut.fetchItems(url: URL.foodItems)
        } catch {
            print(error)
        }
        
        XCTAssertNotNil(actual)
    }
    
    func test_fetch_drink_items_is_not_nil() async {
        let sut = HTTPClient()
        var actual: [Item] = []
        
        do {
            actual = try await sut.fetchItems(url: URL.drinkItems)
        } catch {
            print(error)
        }
        
        XCTAssertNotNil(actual)
    }
    
    func test_fetch_food_categories_is_not_nil() async {
        let sut = HTTPClient()
        var actual: [Category] = []
        
        do {
            actual = try await sut.fetchCategories(url: URL.foodCategories)
        } catch {
            print(error)
        }
        
        XCTAssertNotNil(actual)
    }
}
