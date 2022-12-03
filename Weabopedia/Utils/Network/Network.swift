//
//  Network.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 29/11/22.
//
struct API {
  static let baseUrl = "https://api.jikan.moe/v4/"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {

  enum Get: Endpoint {
    case anime
    case genre

    public var url: String {
      switch self {
      case .anime: return "\(API.baseUrl)anime"
      case .genre: return "\(API.baseUrl)genres/anime"
      }
    }
  }
}
