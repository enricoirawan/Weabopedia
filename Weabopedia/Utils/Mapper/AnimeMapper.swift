//
//  Mapper.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

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
                rating: result.rating ?? "-",
                score: result.score ?? 0.0,
                scoredBy: result.scoredBy ?? 0,
                rank: result.rank,
                synopsis: result.synopsis ?? "-",
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
    
    static func mapAnimeResponseToDomains(
        input animeResponse: AnimeResponse
    ) -> Anime {
        return Anime(
            id: animeResponse.id,
            images: mapImageResponseToDomains(input: animeResponse.images),
            title: animeResponse.title,
            titleEnglish: animeResponse.titleEnglish ?? "-",
            type: animeResponse.type,
            episodes: animeResponse.episodes ?? 0,
            status: animeResponse.status,
            aired: mapAiredResponseToDomains(input: animeResponse.aired),
            duration: animeResponse.duration,
            rating: animeResponse.rating ?? "-",
            score: animeResponse.score ?? 0.0,
            scoredBy: animeResponse.scoredBy ?? 0,
            rank: animeResponse.rank,
            synopsis: animeResponse.synopsis ?? "-",
            season: animeResponse.season ?? "-",
            year: animeResponse.year ?? 0,
            studios: mapFlexibleResponsesToDomains(input: animeResponse.studios),
            genres: mapFlexibleResponsesToDomains(input: animeResponse.genres)
        )
    }
}
