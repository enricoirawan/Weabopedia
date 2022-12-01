//
//  GenreModel.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

import Foundation

struct Genre: Equatable, Identifiable {
    let id: Int
    let name: String
    let url: String
    let count: Int
}
