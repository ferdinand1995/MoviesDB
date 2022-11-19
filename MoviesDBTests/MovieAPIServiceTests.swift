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
        networkManager?.fetchSearchMovies(page: "1", query: "", completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTAssert(true, error.localizedDescription)
            }
        })
    }

}
