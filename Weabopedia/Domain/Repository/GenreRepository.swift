//
//  GenreRepository.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

import Foundation
import Combine

protocol GenreRepository: AnyObject {
    func getListGenre() -> AnyPublisher<[Genre], Error>
}
