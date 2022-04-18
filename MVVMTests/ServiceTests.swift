//
//  ServiceTests.swift
//  MVVMTests
//
//  Created by Aneri Parikh on 15/04/22.
//

import XCTest
@testable import MVVM

class ServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testInValidURL() {
        let expectation = expectation(description: "Data Error")
        let url = "asfjhasf"
        let service = Service()
        service.fetchDemoData(url: url) { data, error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }

    func testValidURL() {
        let expectation = expectation(description: "Data Loaded")
        let url = "http://dummy.restapiexample.com/api/v1/employees"
        let service = Service()
        service.fetchDemoData(url: url) { data, error in
            XCTAssertNotNil(data)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }

    func testValidResponse() {
        let expectation1 = expectation(description: "Data Valid Loaded")
        let url = "http://dummy.restapiexample.com/api/v1/employees"
        let service = Service()
        service.fetchDemoData(url: url) { data, error in
          //  XCTAssertNil(error)
//            XCTAssertEqual(data!.message, "Successfully! All records has been fetched.")
//            XCTAssertEqual(data!.status, "success")

            expectation1.fulfill()
        }

        wait(for: [expectation1], timeout: 10)
    }
}

