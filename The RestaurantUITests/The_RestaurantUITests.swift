//
//  The_RestaurantUITests.swift
//  The RestaurantUITests
//
//  Created by Vlad Redula on 2023/04/08.
//

import XCTest

final class The_RestaurantUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func test_HomeView_foodButton_should_go_to_FoodView() {
        let foodButton = app.scrollViews.otherElements.staticTexts["FOOD"]
        foodButton.tap()
        
        let food = app.staticTexts["FOOD"]
        
        XCTAssertTrue(food.exists)
    }
    
    func test_HomeView_drinkButton_should_go_to_DrinkView() {
        let drinkButton = app.scrollViews.otherElements.staticTexts["DRINK"]
        drinkButton.tap()
        
        let drink = app.staticTexts["DRINK"]
        
        XCTAssertTrue(drink.exists)
    }
}
