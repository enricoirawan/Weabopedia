//
//  GetListGenreUseCase.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//
import Combine

class GetListGenreUseCase {
    private let genreRepository: GenreRepository
    
    required init(genreRepository: GenreRepository) {
        self.genreRepository = genreRepository
    }
    
    func execute() -> AnyPublisher<[Genre], Error> {
        return genreRepository.getListGenre()
    }
}
