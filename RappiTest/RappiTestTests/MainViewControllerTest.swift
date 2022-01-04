//
//  Test_MLTests.swift
//  Test MLTests
//
//  Created by Juan Esteban Pelaez on 14/11/21.
//

import XCTest
@testable import RappiTest

class SearchViewControllerTests: XCTestCase {

    private var sut: MainViewController?

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "mainViewController") as? MainViewController else {
            XCTFail("Could not instantiate viewController as MainViewController")
            return
        }
        sut = viewController
        sut?.databaseManager = MockDataBaseManager()
        sut?.loadViewIfNeeded()
    }
    
    func test_newSearchEmpty() {
        sut?.searchController.searchBar.text = ""
        sut?.filteredList()
    }
    
    func test_newSearchNotResult() {
        sut?.searchController.searchBar.text = "No result"
        sut?.filteredList()
    }
    
    func test_newSearchSuccess() {        
        sut?.searchController.searchBar.text = "test search"
        sut?.filteredList()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
