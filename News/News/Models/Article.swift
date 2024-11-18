//
//  Article.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

struct Article: Codable {
    let title: String
    let description: String?
    let content: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
}
