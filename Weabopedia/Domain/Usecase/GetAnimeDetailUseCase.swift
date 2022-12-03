//
//  GetAnimeDetailUseCase.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 02/12/22.
//
import Combine

class GetAnimeDetailUseCase {
    private let animeRepository: AnimeRepository
    
    required init(animeRepository: AnimeRepository) {
        self.animeRepository = animeRepository
    }
    
    func execute(withAnimeId id: Int) -> AnyPublisher<Anime, Error> {
        return animeRepository.getAnimeDetail(withAnimeId: id)
    }
}
