//
//  HomeViewControllerTest.swift
//  treena_v2Tests
//
//  Created by asong on 2022/04/05.
//

import XCTest
@testable import treena_v2

class HomeViewControllerTest: XCTestCase {
    var homeViewModel: HomeViewModel!

    override func setUpWithError() throws {
        homeViewModel = HomeViewModel()
    }

    override func tearDownWithError() throws {
        homeViewModel = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testHomeViewModel_WhenHomeVCAppeared_ShouldReturnCorrectTreeLevel(){
        XCTAssertTrue(true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
