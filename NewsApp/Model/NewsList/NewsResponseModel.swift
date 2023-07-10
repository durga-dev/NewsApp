//
//  NewsResponseModel.swift
//  NewsApp
//
//  Created by Durga Ballabha Panigrahi on 10/07/23.
//

import Foundation

struct NewsResponseModel: Codable {
    let meta: MetaModel?
    var data: [NewModel]?
}

// MARK: - NewModel
struct NewModel: Codable {
    let uuid, title, description, keywords: String?
    let snippet: String?
    let url: String?
    let imageURL: String?
    let language, publishedAt, source: String?
    let categories: [String]?

    enum CodingKeys: String, CodingKey {
        case uuid, title, description, keywords, snippet, url
        case imageURL = "image_url"
        case language
        case publishedAt = "published_at"
        case source, categories
    }
}

// MARK: - MetaModel
struct MetaModel: Codable {
    let found, returned, limit, page: Int?
}
