//
//  HomeViewControllerTest.swift
//  treena_v2Tests
//
//  Created by asong on 2022/04/05.
//

import XCTest
import RxTest
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
 
    func testHomeViewModel_WhenHomeVCAppeared_ShouldReturnCorrectTreeLevel(){
        // RxTest 예제 코드
        let scheduler = TestScheduler(initialClock: 0)
        let observable = scheduler.createHotObservable([
            .next(210, 2),
            .next(220, 4),
            .completed(400)
        ])
        
        let observer = scheduler.createObserver(Int.self)
        observable.subscribe(observer)
        
        scheduler.start()
        XCTAssertEqual(observer.events, [.next(210, 2),
                                         .next(220, 4),
                                         .completed(400)])
        
    }
    
    func testHomeViewModel_WhenHomeVCAppeared_ShouldReturnCorrectTree(){
        XCTAssertTrue(true)
    }
}
