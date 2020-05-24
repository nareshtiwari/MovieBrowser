//
//  MovieRouter.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-23.
//

import Foundation
import Alamofire

enum MovieRouter : URLRequestConvertible {
    
    case movieList(parameter: [String: Int])
    case movieByMostPopular(parameter: [String: Int])
    case movieByHighestRating(parameter: [String: Int])
    case searchMovie(parameter: [String:Any])

}
extension MovieRouter {
        
    var method: HTTPMethod {
            
      switch self {
             
        case .movieList:
            return .get
        case .movieByMostPopular:
            return .get
        case .movieByHighestRating:
            return .get
        case .searchMovie:
            return .get
           
        }
    }
        
    var path: String {
            
       switch self {
                
        case .movieList:
            return URLConstants.getMovieList
        case .movieByMostPopular:
            return URLConstants.mostPopular
        case .movieByHighestRating:
            return URLConstants.mostHighestRating
        case .searchMovie:
            return URLConstants.searchMovieApi
                
        }
    }
        
    func asURLRequest() throws -> URLRequest {
            
        let url = try URLConstants.BaseURL.asURL()
            
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
            
        switch self {
                
            case .movieList(let parameter):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameter)
            case .movieByMostPopular(let parameter):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameter)
            case .movieByHighestRating(let parameter):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameter)
            case .searchMovie(let parameter):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameter)
                
        }
        return urlRequest
    }
}


