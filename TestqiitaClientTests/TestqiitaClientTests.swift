//
//  TestqiitaClientTests.swift
//  TestqiitaClientTests
//
//  Created by 舘佳紀 on 2020/08/13.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//


import UIKit
import XCTest
import SafariServices
@testable import TestqiitaClient

class TestqiitaClientTests: XCTestCase {
    
//    func test_preview() {
//        let article = Article(title: "hoge")
//        let client = FakeArticleListAPIClient(fakeResponse: [article])
//        //let vc = ArticleListViewController(client: client)
//
//        let window = UIWindow()
//        window.rootViewController = vc
//        window.makeKeyAndVisible()
//
//        XCTAssertEqual(vc.titleLabel.text, "hoge")
//    }
    
    
    
    /*
    func test_previewDetailView() {
        let article = Article(title: "test", url: "")
        let client = FakeArticleListAPIClient(fakeResponse: [article])
        let vc = ArticleListViewController(client: client)
        
        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(vc.presentedViewController is SFSafariViewController)
        
    }
 */


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

}

//class FakeArticleListAPIClient: ArticleListAPIClientProtocol {
//    let fakeResponse: [Article]
//    
//    init(fakeResponse: [Article]) {
//        self.fakeResponse = fakeResponse
//    }
//    
//    func featch(completion: @escaping (([Article]?) -> Void)) {
//        completion(fakeResponse)
//    }
//}
