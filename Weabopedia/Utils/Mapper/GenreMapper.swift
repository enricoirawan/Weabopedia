//
//  GenreMapper.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

import Foundation

final class GenreMapper {
    static func mapGenreResponsesToDomains(
        input genreResponses: [GenreResponse]
    ) -> [Genre] {
        return genreResponses.map { result in
            return Genre(
                id: result.id,
                name: result.name,
                url: result.url,
                count: result.count
            )
        }
    }
}
