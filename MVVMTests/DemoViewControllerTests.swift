//
//  DemoViewControllerTests.swift
//  MVVMTests
//
//  Created by Aneri Parikh on 15/04/22.
//

import XCTest
@testable import MVVM

class DemoViewControllerTests: XCTestCase {

    var vc : DemoViewController!
    let service = MockService()

    override func setUp() {
        vc = DemoViewController()
        vc.service = service
        vc.demoVM = DemoViewModel(service: service)

    }
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

    func testDataLoaded() {
        service.successCase = true
        vc.demoVM?.fetchData()
        XCTAssertNotNil(vc.demoVM?.demo)
        XCTAssertEqual(vc.demoVM?.demo?.data.count, 3)
    }

    func testDataFailed() {
        service.successCase = false
        vc.demoVM?.fetchData()
        XCTAssertNil(vc.demoVM?.demo)
    }

//    func testNoOfrows() {
//        service.successCase = true
//        vc.demoVM?.fetchData()
//        XCTAssertEqual(vc.testHook.tableView.numberOfRows(inSection: 0), 3)
//    }
//
//    func testCellDatas() {
//        service.successCase = true
//        vc.demoVM?.fetchData()
//        let cell = vc.testHook.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? DemoViewCellTableViewCell
//        XCTAssertEqual(cell?.titleLabel.text, "Pummy")
//    }
}


class MockService: ServiceLayer {
    var successCase = true
    func fetchDemoData(url: String, completion: @escaping (Demo?, String?) -> ()) {
        if successCase {
            let demo = Demo(status: "", data: [.init(id: 1, employeeName: "Aneri", employeeSalary: 50, employeeAge: 20, profileImage: ""),
                                               .init(id: 2, employeeName: "Pummy", employeeSalary: 50, employeeAge: 20, profileImage: ""),
                                               .init(id: 3, employeeName: "Ravij", employeeSalary: 50, employeeAge: 20, profileImage: "")], message: "")
            return completion(demo,nil)
        } else {
            return completion(nil, "Parsing error")
        }
    }
}

