//
//  Constant.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-23.
//

import Foundation

struct HTTPHeaderConstants {
    
    /// Header Name for authorization header
    static let AuthorizationHeaderName = "Authorization"
    
    /// Header Name for identifying each request
    static let MobileIdentifierHeaderName = "platform"
    
    /// Header Value for identifying each request
    static let MobileIdentifierHeaderValue = "ios"
}
struct URLConstants {
    
    static let BaseURL = "https://api.themoviedb.org/3/"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/original"
    
    static let getMovieList = "discover/movie"
    static let hideUserApi = "user/hide"
    static let mostPopular = "movie/popular"
    static let mostHighestRating = "movie/top_rated"
    static let searchMovieApi = "search/movie"
    static let movieDetailApi = "movie/"


}
enum ResponseKey : String{
    case result = "results"
    case released = "Released"
}
enum SortType : String{
    case mostPopular = "Most Popular"
    case mostRated = "Most Rating"
}
enum ReuseIdentifier : String{
    case collectionReuseIdentifier = "MovieCollectionCell"
}
enum UserDefaultKey : String{
    case apiToken = "Api_token"
}
