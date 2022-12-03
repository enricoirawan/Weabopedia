//
//  SearchAnimeUseCase.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 03/12/22.
//
import Combine

class SearchAnimeUseCase {
    private let animeRepository: AnimeRepository
    
    required init(animeRepository: AnimeRepository) {
        self.animeRepository = animeRepository
    }
    
    func execute(withQuery query: String) -> AnyPublisher<[Anime], Error> {
        return animeRepository.searchAnime(withQuery: query)
    }
}
