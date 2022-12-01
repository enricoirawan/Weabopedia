//
//  Mapper.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

import Foundation

final class AnimeMapper {
    static func mapAnimeResponsesToDomains(
        input animeResponses: [AnimeResponse]
      ) -> [Anime] {
        return animeResponses.map { result in
            return Anime(
                id: result.id,
                images: mapImageResponseToDomains(input: result.images),
                title: result.title,
                titleEnglish: result.titleEnglish ?? "-",
                type: result.type,
                episodes: result.episodes ?? 0,
                status: result.status,
                aired: mapAiredResponseToDomains(input: result.aired),
                duration: result.duration,
                rating: result.rating,
                score:
                    result.score,
                scoredBy:
                    result.scoredBy,
                rank: result.rank,
                synopsis: result.synopsis,
                season: result.season ?? "?",
                year: result.year ?? 0,
                studios: mapFlexibleResponsesToDomains(input: result.studios),
                genres: mapFlexibleResponsesToDomains(input: result.genres)
            )
        }
    }
    
    static func mapImageResponseToDomains(
        input imageResponses: ImageResponse
    ) -> Image {
        return Image(jpg: mapJpgResponsetoDomains(input: imageResponses.jpg))
    }
    
    static func mapJpgResponsetoDomains(
        input jpgResponse: JpgResponse
    ) -> Jpg {
        return Jpg(
            imageURL: jpgResponse.imageURL,
            smallImageURL: jpgResponse.smallImageURL,
            largeImageURL: jpgResponse.largeImageURL
        )
    }
    
    static func mapAiredResponseToDomains(
        input airedResponse: AiredResponse
    ) -> Aired {
        return Aired(
            string: airedResponse.string
        )
    }
    
    static func mapFlexibleResponsesToDomains(
        input responses: [FlexibleResponse]
    ) -> [Flexible] {
        return responses.map { item in
            return Flexible(
                id: item.id,
                type: item.type,
                name: item.name,
                url: item.url
            )
        }
    }
}
