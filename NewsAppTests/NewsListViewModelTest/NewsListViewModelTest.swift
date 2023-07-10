//
//  NewsListViewModelTest.swift
//  NewsAppTests
//
//  Created by Durga Ballabha Panigrahi on 10/07/23.
//

import XCTest
@testable import NewsApp
final class NewsListViewModelTest: XCTestCase {

    private let expectationsTimeOut: TimeInterval = 3
    private var newsListViewModel: NewsListViewModelProtocol?
    override func setUpWithError() throws {
        let httpUtility: HTTPUtility = HTTPUtility()
        let newsListResource: NewsListResource = NewsListResource(httpUtility: httpUtility)
        newsListViewModel = NewsListViewModel(resource: newsListResource)
    }

    func testViewDidLoadSuccess() {
        let startedLoadingExpectation = expectation(
            description: #function
        )
        
        newsListViewModel?.onContentLoaded = { data in
            DispatchQueue.main.async {
                XCTAssertNotNil(data)
                startedLoadingExpectation.fulfill()
            }
        }
        
        newsListViewModel?.viewDidLoad()
        
        waitForExpectations(
            timeout: .infinity,
            handler: nil
        )
    }

}
