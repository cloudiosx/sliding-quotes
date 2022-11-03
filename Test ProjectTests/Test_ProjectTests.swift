//
//  Test_ProjectTests.swift
//  Test ProjectTests
//
//  Created by John Kim on 11/3/22.
//

import XCTest
@testable import Test_Project

final class Test_ProjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testQuotesModel() throws {
        if let url = Bundle.main.url(forResource: "AllQuotes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Quote].self, from: data)
                XCTAssertEqual(jsonData.first?.author, "Leia Organa")
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
