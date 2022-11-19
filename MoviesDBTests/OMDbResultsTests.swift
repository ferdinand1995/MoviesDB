//
//  OMDbResultsTests.swift
//  MoviesDBTests
//
//  Created by Ferdinand on 19/11/22.
//

import XCTest
@testable import MoviesDB

class OMDbResultsTests: XCTestCase {

    func testParseEmptyResponse() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "search_result_empty_sample", withExtension: "json") else {
            XCTFail("Missing file: search_result_empty_sample.json")
            return
        }
        let data = try Data(contentsOf: url)
        do {
            let result: OMDBResult = try JSONDecoder().decode(OMDBResult.self, from: data)
            XCTAssertNotNil(result.response)
            XCTAssertEqual(result.response?.lowercased(), "False".lowercased())
        } catch {}
    }
    
    func testParseSearchResponse() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "search_result_sample", withExtension: "json") else {
            XCTFail("Missing file: search_result_sample.json")
            return
        }
        let data = try Data(contentsOf: url)
        do {
            let result: OMDBResult = try JSONDecoder().decode(OMDBResult.self, from: data)
            XCTAssertNotNil(result.response)
            XCTAssertEqual(result.response?.lowercased(), "True".lowercased())
            XCTAssertNotNil(result.search)
            XCTAssertTrue(result.search!.count > 0)
        } catch {}
    }
    
    func testParseResponseById() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "search_result_sample_by_id", withExtension: "json") else {
            XCTFail("Missing file: search_result_sample_by_id.json")
            return
        }
        let data = try Data(contentsOf: url)
        do {
            let result: OMDBResult = try JSONDecoder().decode(OMDBResult.self, from: data)
            XCTAssertNotNil(result.response)
            XCTAssertEqual(result.response?.lowercased(), "True".lowercased())
        } catch {}
    }

}
