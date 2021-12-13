//
//  DetailViewControllerTest.swift
//  Test MLTests
//
//  Created by Juan Esteban Pelaez on 17/11/21.
//

import XCTest
@testable import RappiTest

class DetailViewControllerTests: XCTestCase {

    private var sut: DetailViewController!
    
    private let movie = MovieItem(backdropPath: "", id: 0, overview: "Description", posterPath: "/2jVVDtDaeMxmcvrz2SNyhMcYtWc.jpg", releaseDate: "2021-12-01", title: "Encanto", voteAverage: 5.5)
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "detailViewController") as? DetailViewController else {
            XCTFail("Could not instantiate viewController as DetailViewController")
            return
        }
        sut = viewController
        sut.movieItem = movie
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
