//
//  AnimeRemoteRepository.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

import Foundation
import Combine

protocol AnimeRepository: AnyObject {
    func getListAnime(withGenreId genreId: Int) -> AnyPublisher<[Anime], Error>
}
