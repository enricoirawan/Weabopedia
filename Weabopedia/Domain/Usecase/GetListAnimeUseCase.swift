//
//  GetAnimeListUseCase.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//
import Combine

class GetListAnimeUseCase {
    private let animeRepository: AnimeRepository
    
    required init(animeRepository: AnimeRepository) {
        self.animeRepository = animeRepository
    }
    
    func execute(withGenreId genreId: Int) -> AnyPublisher<[Anime], Error> {
        return animeRepository.getListAnime(withGenreId: genreId)
    }
}
