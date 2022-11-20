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
    let largeTimeout: TimeInterval = 30

    override func setUp() {
        networkManager = NetworkManager()
    }

    func testFetchMovies() {
        let expectation = expectation(description: "test_fetch_movie_by_title")
        var omdbResult: OMDBResult?
        networkManager?.fetchSearchMovies(page: "1", title: "marvel", completion: { result in
            switch result {
            case .success(let response):
                XCTAssertTrue(true)
                omdbResult = response
                expectation.fulfill()
            case .failure(let error):
                print("error in test - \(error)")
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: largeTimeout, handler: nil)
        XCTAssertNotNil(omdbResult)
        XCTAssertEqual(omdbResult?.response?.lowercased(), "true")
    }
    
    func testFetchMovieById() {
        let expectation = expectation(description: "test_fetch_movie_by_id")
        var omdbResult: OMDBResult?
        networkManager?.fetchMovie(by: "tt0325980", completion: { result in
            switch result {
            case .success(let response):
                XCTAssertTrue(true)
                omdbResult = response
                expectation.fulfill()
            case .failure(let error):
                print("error in test - \(error)")
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: largeTimeout, handler: nil)
        XCTAssertNotNil(omdbResult)
        XCTAssertEqual(omdbResult?.response?.lowercased(), "true")
    }

}
