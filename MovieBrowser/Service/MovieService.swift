//
//  MovieService.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-23.
//

import Foundation
import Alamofire

class MovieService {

    func getAllMovieList(parameter: [String: Int],completionHandler: @escaping (_ response:Any?) -> Void) -> Void {
    
      MovieBrowserNetwork.sharedInstance.request(MovieRouter.movieList(parameter: parameter)).responseJSON { (response) in
        
          if let json = response.result.value {
              completionHandler(json)
          }
          else{
              completionHandler(nil)
          }
      }
    }
    func movieByMostPopular(parameter: [String: Int],completionHandler: @escaping (_ response:Any?) -> Void) -> Void {
    
      MovieBrowserNetwork.sharedInstance.request(MovieRouter.movieByMostPopular(parameter: parameter)).responseJSON { (response) in
        
          if let json = response.result.value {
              completionHandler(json)
          }
          else{
              completionHandler(nil)
          }
      }
    }
    func movieByHighestRating(parameter: [String: Int],completionHandler: @escaping (_ response:Any?) -> Void) -> Void {
       
         MovieBrowserNetwork.sharedInstance.request(MovieRouter.movieByHighestRating(parameter: parameter)).responseJSON { (response) in
           
             if let json = response.result.value {
                 completionHandler(json)
             }
             else{
                 completionHandler(nil)
             }
         }
    }
    func getSearchMovie(parameter: [String: Any],completionHandler: @escaping (_ response:Any?) -> Void) -> Void {
       
         MovieBrowserNetwork.sharedInstance.request(MovieRouter.searchMovie(parameter: parameter)).responseJSON { (response) in
           
             if let json = response.result.value {
                 completionHandler(json)
             }
             else{
                 completionHandler(nil)
             }
         }
    }
 
}

