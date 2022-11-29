//
//  AnimeResponse.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 29/11/22.
//

import Foundation

struct AnimeResponse: Codable {
    let data: [Anime]
}

// MARK: - Anime
struct Anime: Codable {
    let malID: Int
    let images: [String: Image]
    let title, titleEnglish: String
    let type: String
    let episodes: Int
    let status: String
    let aired: Aired
    let duration, rating: String
    let score: Double
    let scoredBy, rank: Int
    let synopsis, season: String
    let year: Int
    let studios, genres: [Demographic]

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case images, title
        case titleEnglish = "title_english"
        case type, episodes, status, aired, duration, rating, score
        case scoredBy = "scored_by"
        case rank, synopsis, season, year, studios, genres
    }
}

// MARK: - Image
struct Image: Codable {
    let imageURL, smallImageURL, largeImageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Aired
struct Aired: Codable {
    let from, to: Date
    let prop: Prop
    let string: String
}

// MARK: - Prop
struct Prop: Codable {
    let from, to: From
}

// MARK: - From
struct From: Codable {
    let day, month, year: Int
}

// MARK: - Demographic
struct Demographic: Codable {
    let malID: Int
    let type: TypeEnum
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}

enum TypeEnum: String, Codable {
    case anime = "anime"
}
