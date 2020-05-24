//
//  MovieModel.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-23.
//

import Foundation

struct MovieModel {
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var poster_path: String
    var release_date: String
    var title: String
    var video: Int
    var vote_average: String
    var vote_count: Int
    var adult: Int
    var backdrop_path: String
    var genre_ids: [Int]
    
init(_ dictionary: [String: Any]) {
      self.id = dictionary["id"] as? Int ?? 0
      self.original_language = dictionary["original_language"] as? String ?? ""
      self.original_title = dictionary["original_title"] as? String ?? ""
      self.overview = dictionary["overview"] as? String ?? ""
      self.popularity = dictionary["popularity"] as? Double ?? 0.0
      self.poster_path = dictionary["poster_path"] as? String ?? ""
      self.release_date = dictionary["release_date"] as? String ?? ""
      self.title = dictionary["title"] as? String ?? ""
      self.video = dictionary["video"] as? Int ?? 0
      self.vote_average = dictionary["vote_average"] as? String ?? ""
      self.vote_count = dictionary["vote_count"] as? Int ?? 0
      self.adult = dictionary["adult"] as? Int ?? 0
      self.backdrop_path = dictionary["backdrop_path"] as? String ?? ""
      self.genre_ids = dictionary["genre_ids"] as? [Int] ?? []
    }
}

