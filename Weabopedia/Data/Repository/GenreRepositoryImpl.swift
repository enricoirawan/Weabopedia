//
//  GenreRepositoryImpl.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//
import Combine

class GenreRepositoryImpl: GenreRepository {
    private let genreRemoteDataSource: GenreRemoteDataSource
    
    required init(genreRemoteDataSource: GenreRemoteDataSource) {
        self.genreRemoteDataSource = genreRemoteDataSource
    }
    
    func getListGenre() -> AnyPublisher<[Genre], Error> {
        return genreRemoteDataSource.getListGenre()
            .map { GenreMapper.mapGenreResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
}
