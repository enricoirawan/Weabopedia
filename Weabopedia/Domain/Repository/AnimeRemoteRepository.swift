//
//  AnimeRemoteRepository.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

import Combine

protocol AnimeRepository: AnyObject {
    func getListAnime(withGenreId genreId: Int) -> AnyPublisher<[Anime], Error>
    func getAnimeDetail(withAnimeId id: Int) -> AnyPublisher<Anime, Error>
    func searchAnime(withQuery query: String) -> AnyPublisher<[Anime], Error>
}
