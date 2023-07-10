//
//  NewsRequestModel.swift
//  NewsApp
//
//  Created by Durga Ballabha Panigrahi on 10/07/23.
//

import Foundation

public struct NewsRequestModel: RequestModelProtocol {
    
    struct QueryParameters {
        static let apiToken = "api_token"
        static let page: String = "page"
        static let limit: String = "limit"
        static let language: String = "language"
    }
    
    let limit: Int
    let language: String = "en"
    let page: Int
    
    var baseURL: String {
        APIConfiguration.newsAPIEndPoint
    }
    
    var path: String {
        "/v1/news/all"
    }
    
    var httpMethod: HTTPMethod {
        .GET
    }
    
    private var queryParameters: [String: String] {
        [
            QueryParameters.apiToken: APIConfiguration.apiKey,
            QueryParameters.page: "\(page)",
            QueryParameters.limit: "\(limit)",
            QueryParameters.language: language
        ]
    }
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        queryParameters.forEach { (key, value) in
            queryItems.append(
                URLQueryItem(name: key, value: value)
            )
        }
        return queryItems
    }
}
