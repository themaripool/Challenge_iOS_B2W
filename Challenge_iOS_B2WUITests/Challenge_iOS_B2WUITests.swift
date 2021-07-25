//
//  Challenge_iOS_B2WUITests.swift
//  Challenge_iOS_B2WUITests
//
//  Created by Mariela Mendonça de Andrade on 13/07/21.
//

import XCTest

class Challenge_iOS_B2WUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        app.launch()
    }
    
    func testSearch() throws {
        let searchBar = app.tables
        searchBar.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .searchField).element.tap()
        searchBar/*@START_MENU_TOKEN@*/.buttons["1, Bulbasaur"]/*[[".cells[\"1, Bulbasaur\"].buttons[\"1, Bulbasaur\"]",".buttons[\"1, Bulbasaur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(5)
    }
    
    func testLoadMore() throws {
        let tablesQuery = app.tables
        let button = tablesQuery/*@START_MENU_TOKEN@*/.buttons["6, Charizard"]/*[[".cells[\"6, Charizard\"].buttons[\"6, Charizard\"]",".buttons[\"6, Charizard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        button/*@START_MENU_TOKEN@*/.swipeUp()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        tablesQuery.buttons["13, Weedle"].swipeUp()
        tablesQuery.buttons["17, Pidgeotto"].swipeUp()
    }
    
    func testGoToDetails() throws {
        let pokemon = app.tables.buttons["3, Venusaur"]
        pokemon.tap()
        sleep(5)
    }
    
    func testTypeTap() throws {
        let pokemon = app.tables.buttons["3, Venusaur"]
        pokemon.tap()
        let type = app.scrollViews.otherElements
        type.buttons["poison"].tap()
    }
    
    func testAbilitiesTap() throws {
        let pokemon = app.tables.buttons["3, Venusaur"]
        pokemon.tap()
        let abilitie = app.scrollViews.otherElements
        abilitie.buttons["Chlorophyll"].tap()
    }
    
    func testVarietyItens() throws {
        let pokemon = app.tables.buttons["3, Venusaur"]
        pokemon.tap()
        app.scrollViews.otherElements.containing(.button, identifier:"Back").children(matching: .button).element(boundBy: 3).tap()
        sleep(2)
        let button = app.buttons["venusaur-mega"]
        print("exists = \(button.exists), hittable = \(button.isHittable)")
        app.buttons["venusaur-mega"].tap()
        sleep(5)
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
