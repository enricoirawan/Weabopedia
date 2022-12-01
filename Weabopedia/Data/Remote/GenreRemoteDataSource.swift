//
//  GenreRemoteDataSource.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

import Foundation
import Alamofire
import Combine

protocol GenreRemoteDataSource: AnyObject {
    func getListGenre() -> AnyPublisher<[GenreResponse], Error>
}

class GenreRemoteDataSourceImpl: GenreRemoteDataSource {
    func getListGenre() -> AnyPublisher<[GenreResponse], Error> {
        return Future<[GenreResponse], Error> { completion in
            var components = URLComponents(string: Endpoints.Get.genre.url)!
            components.queryItems = [
                URLQueryItem(name: "filter", value: "genres")
            ]
            
            if let url = components.url {
                AF.request(url)
                  .validate()
                  .responseDecodable(of: GenreResponses.self) { response in
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
