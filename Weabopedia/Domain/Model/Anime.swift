//
//  AnimeModel.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

struct Anime: Equatable, Identifiable {
    let id: Int
    let images: Image
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
    let studios, genres: [Flexible]
}

// MARK: - Image
struct Image: Equatable {
    let jpg: Jpg
}

// MARK: - Jpg
struct Jpg: Equatable {
    let imageURL, smallImageURL, largeImageURL: String
}

// MARK: - Aired
struct Aired: Equatable {
    let string: String
}

// MARK: - Demographic
struct Flexible: Equatable {
    let id: Int
    let type: TypeEnum
    let name: String
    let url: String
}
