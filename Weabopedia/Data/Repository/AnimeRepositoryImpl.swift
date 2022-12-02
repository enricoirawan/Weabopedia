//
//  AnimeRepository.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

import Foundation
import Combine

class AnimeRepositoryImpl: AnimeRepository {
    private let animeRemoteDataSource: AnimeRemoteDataSource
    
    required init(animeRemoteDataSource: AnimeRemoteDataSource) {
        self.animeRemoteDataSource = animeRemoteDataSource
    }
    
    func getListAnime(withGenreId genreId: Int) -> AnyPublisher<[Anime], Error> {
        return animeRemoteDataSource.getListAnime(withGenreId: genreId)
            .map { AnimeMapper.mapAnimeResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getAnimeDetail(withAnimeId id: Int) -> AnyPublisher<Anime, Error> {
        return animeRemoteDataSource.getAnimeDetail(withId: id)
            .map { AnimeMapper.mapAnimeResponseToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
}
