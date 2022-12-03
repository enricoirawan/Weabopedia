//
//  AnimeRemoteDataSource.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 29/11/22.
//

import Foundation
import Alamofire
import Combine

protocol AnimeRemoteDataSource: AnyObject {
    func getListAnime(withGenreId genreId: Int) -> AnyPublisher<[AnimeResponse], Error>
    func getAnimeDetail(withId id: Int) -> AnyPublisher<AnimeResponse, Error>
    func searchAnime(withQuery query: String) -> AnyPublisher<[AnimeResponse], Error>
}

class AnimeRemoteDataSourceImpl: AnimeRemoteDataSource {
    func getListAnime(withGenreId genreId: Int) -> AnyPublisher<[AnimeResponse], Error> {
        return Future<[AnimeResponse], Error> { completion in
            var components = URLComponents(string: Endpoints.Get.anime.url)!
            components.queryItems = [
                URLQueryItem(name: "genres", value: "\(genreId)"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "limit", value: "10"),
                URLQueryItem(name: "sort", value: "asc"),
                URLQueryItem(name: "order_by", value: "popularity"),
                URLQueryItem(name: "min_score", value: "7")
            ]
            
            if let url = components.url {
                AF.request(url)
                  .validate()
                  .responseDecodable(of: AnimeResponses.self) { response in
                      
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.data))
                    case .failure:
                      completion(.failure(URLError.invalidResponse))
                    }
                  }
            }
        }.eraseToAnyPublisher()
    }
    
    func getAnimeDetail(withId id: Int) -> AnyPublisher<AnimeResponse, Error> {
        return Future<AnimeResponse, Error> { completion in
            if let url = URL(string: "\(Endpoints.Get.anime.url)/\(id)") {
                AF.request(url)
                  .validate()
                  .responseDecodable(of: AnimeDetailResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.data))
                    case .failure:
                      completion(.failure(URLError.invalidResponse))
                    }
                  }
            }
        }.eraseToAnyPublisher()
    }
    
    func searchAnime(withQuery query: String) -> AnyPublisher<[AnimeResponse], Error> {
        return Future<[AnimeResponse], Error> { completion in
            var components = URLComponents(string: Endpoints.Get.anime.url)!
            components.queryItems = [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "limit", value: "10"),
                URLQueryItem(name: "sort", value: "asc"),
                URLQueryItem(name: "order_by", value: "popularity")
            ]
            
            if let url = components.url {
                AF.request(url)
                  .validate()
                  .responseDecodable(of: AnimeResponses.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.data))
                    case .failure:
                      completion(.failure(URLError.invalidResponse))
                    }
                  }
            }
        }.eraseToAnyPublisher()
    }
}
