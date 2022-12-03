//
//  AnimeResponse.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 29/11/22.
//

// MARK: - AnimeResponses
struct AnimeResponses: Codable {
    let data: [AnimeResponse]
}

// MARK: - Anime
struct AnimeResponse: Codable {
    let id: Int
    let images: ImageResponse
    let title: String
    let titleEnglish: String?
    let type: String
    let episodes: Int?
    let status: String
    let aired: AiredResponse
    let duration: String
    let rating: String?
    let score: Double?
    let scoredBy: Int?
    let rank: Int
    let synopsis: String?
    let season: String?
    let year: Int?
    let studios, genres: [FlexibleResponse]

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case images, title
        case titleEnglish = "title_english"
        case type, episodes, status, aired, duration, rating, score
        case scoredBy = "scored_by"
        case rank, synopsis, season, year, studios, genres
    }
}

// MARK: - Image
struct ImageResponse: Codable {
    let jpg: JpgResponse
}

// MARK: - Jpg
struct JpgResponse: Codable {
    let imageURL, smallImageURL, largeImageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Aired
struct AiredResponse: Codable {
    let string: String
}

// MARK: - Demographic
struct FlexibleResponse: Codable {
    let id: Int
    let type: TypeEnum
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case type, name, url
    }
}

enum TypeEnum: String, Codable {
    case anime
}
