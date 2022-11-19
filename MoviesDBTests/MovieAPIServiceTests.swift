//
//  MovieAPIServiceTests.swift
//  MoviesDBTests
//
//  Created by Ferdinand on 19/11/22.
//


import XCTest
@testable import MoviesDB

final class MovieAPIServiceTests: XCTestCase {

    var networkManager: NetworkManager?

    override func setUp() {
        networkManager = NetworkManager()
    }

    func testFetchMovies() {
        networkManager?.fetchSearchMovies(page: "1", title: "marvel", completion: { result in
            if case let .success(response) = result {
                XCTAssertNotNil(response.search)
                XCTAssertTrue(response.search!.count > 0)
                XCTAssertNotNil(response)
            }
        })
    }

}
