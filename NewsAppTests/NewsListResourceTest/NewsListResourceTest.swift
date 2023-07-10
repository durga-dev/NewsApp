//
//  NewsListResourceTest.swift
//  NewsAppTests
//
//  Created by Durga Ballabha Panigrahi on 10/07/23.
//

import XCTest
@testable import NewsApp
final class NewsListResourceTest: XCTestCase {

    private var dataResource: NewsListResource?
    private var requestModel: RequestModelProtocol?
    
    override func setUpWithError() throws {
        let httpUtility = HTTPUtility()
        dataResource = NewsListResource(httpUtility: httpUtility)
        requestModel = NewsRequestModel(limit: 3, page: 1)
    }

    
    func testGetDataSuccess() {
        let startedLoadingExpectation = expectation(
            description: #function
        )
        
        dataResource?.getNewsList(
            request: requestModel!,
            completion: { newsResponse in
                
                DispatchQueue.main.async {
                    XCTAssertNotNil(newsResponse?.data)
                    startedLoadingExpectation.fulfill()
                }
            }
        )
        
        waitForExpectations(
            timeout: .infinity,
            handler: nil
        )
    }
}
