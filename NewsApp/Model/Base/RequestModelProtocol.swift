//
//  RequestModelProtocol.swift
//  NewsApp
//
//  Created by User on 08/07/23.
//

import Foundation

protocol RequestModelProtocol {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}
