//
//  HTTPUtilityTest.swift
//  NewsAppTests
//
//  Created by Durga Ballabha Panigrahi on 10/07/23.
//

import XCTest
@testable import NewsApp

final class HTTPUtilityTest: XCTestCase {

    private let expectationsTimeOut: TimeInterval = 20
    private var httpUtility: HTTPUtility?
    override func setUpWithError() throws {
        httpUtility = HTTPUtility()
    }

    func testGetDataSuccess() {
        let startedLoadingExpectation = expectation(
            description: #function
        )

        httpUtility?.getData(
            requestUrl: URL(string: "https://api.thenewsapi.com/v1/news/all?limit=3&language=en&api_token=i2MitBgqIXCoF8yJYcjMz8UlJvt7rdBGkfp72atC&page=1")!,
            resultType: NewsResponseModel.self
        ) { newsAPIResponse in

            DispatchQueue.main.async {
                XCTAssertNotNil(newsAPIResponse)
                startedLoadingExpectation.fulfill()
            }
        }

        waitForExpectations(
            timeout: .infinity,
            handler: nil
        )
    }

    func testGetDataInvalidURLResultNil() {
        let startedLoadingExpectation = expectation(
            description: #function
        )

        httpUtility?.getData(
            requestUrl: URL(string: "https://api.thenewsapi.com/v1/news/al")!,
            resultType: NewsResponseModel.self
        ) { newsAPIResponse in

            DispatchQueue.main.async {
                XCTAssertNil(newsAPIResponse?.data)
                startedLoadingExpectation.fulfill()
            }
        }

        waitForExpectations(
            timeout: expectationsTimeOut,
            handler: nil
        )
    }
}
