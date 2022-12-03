//
//  GenreResponse.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

// MARK: - GenreResponses
struct GenreResponses: Codable {
    let data: [GenreResponse]
}

// MARK: - GenreResponse
struct GenreResponse: Codable {
    let id: Int
    let name: String
    let url: String
    let count: Int

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case name, url, count
    }
}
