//
//  RequestModelProtocol.swift
//  NewsApp
//
//  Created by Durga Ballabha Panigrahi on 10/07/23.
//

import Foundation

protocol RequestModelProtocol {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}
