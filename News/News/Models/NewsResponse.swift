//
//  NewsResponse.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
    let request: URL?
}
