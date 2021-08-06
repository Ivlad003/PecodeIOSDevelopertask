//
//  APINewsSuccessResponse.swift
//  APINewsSuccessResponse
//
//  Created by kosmodev on 05.08.2021.
//

import Foundation

struct NewsModel: Codable {
    let status: String?
    let totalResults: Int?
    var articles: [Article]?
}

