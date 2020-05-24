//
//  MovieDetailModel.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-23.
//

import Foundation

struct MovieDetailModel {
    var adult: Bool
    var backdrop_path: String
    var belongs_to_collection: Int
    var budget: Int
    var genres: [[String:Any]]
    var homepage: String
    var id: Int
    var imdb_id: String
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Int
    var poster_path: String
    var production_companies: [[String:String]]
    var production_countries: [[String:String]]
    var release_date: String
    var revenue: Int
    var runtime: Int
    var spoken_languages: [[String:String]]
    var status: String
    var tagline: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
    
init(_ dictionary: [String: Any]) {
      self.adult = dictionary["adult"] as? Bool ?? false
      self.backdrop_path = dictionary["backdrop_path"] as? String ?? ""
      self.belongs_to_collection = dictionary["belongs_to_collection"] as? Int ?? 0
      self.budget = dictionary["budget"] as? Int ?? 0
      self.genres = dictionary["genres"] as? [[String:Any]] ?? []
      self.homepage = dictionary["homepage"] as? String ?? ""
      self.id = dictionary["id"] as? Int ?? 0
      self.imdb_id = dictionary["imdb_id"] as? String ?? ""
      self.original_language = dictionary["original_language"] as? String ?? ""
      self.original_title = dictionary["original_title"] as? String ?? ""
      self.overview = dictionary["overview"] as? String ?? ""
      self.popularity = dictionary["popularity"] as? Int ?? 0
      self.poster_path = dictionary["poster_path"] as? String ?? ""
      self.production_companies = dictionary["production_companies"] as? [[String:String]] ?? []
      self.production_countries = dictionary["production_countries"] as? [[String:String]] ?? []
      self.release_date = dictionary["release_date"] as? String ?? ""
      self.revenue = dictionary["revenue"] as? Int ?? 0
      self.runtime = dictionary["runtime"] as? Int ?? 0
      self.spoken_languages = dictionary["spoken_languages"] as? [[String:String]] ?? []
      self.status = dictionary["status"] as? String ?? ""
      self.tagline = dictionary["tagline"] as? String ?? ""
      self.title = dictionary["title"] as? String ?? ""
      self.video = dictionary["video"] as? Bool ?? false
      self.vote_average = dictionary["vote_average"] as? Double ?? 0.0
      self.vote_count = dictionary["vote_count"] as? Int ?? 0

    }
}
