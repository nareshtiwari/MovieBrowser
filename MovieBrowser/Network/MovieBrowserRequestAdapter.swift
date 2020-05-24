//
//  MovieBrowserRequestAdapter.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-23.
//

import Foundation
import Alamofire

class MovieBrowserRequestAdapter : RequestAdapter {
    
    private var apiToken: String?
    
    init() {
        apiToken = nil
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        
        var urlRequest = urlRequest
        urlRequest.setValue(HTTPHeaderConstants.MobileIdentifierHeaderValue, forHTTPHeaderField:HTTPHeaderConstants.MobileIdentifierHeaderName)
        
        setAuthorizationHeader(urlRequest: &urlRequest)
        
        return urlRequest
    }

    private func setAuthorizationHeader(urlRequest: inout URLRequest) -> Void {
        //This token is provided by TMdb
        
        apiToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMTc0ZDBmOTYzNTc5MzllZWRkNGUyMDEzMTMxYjcyOCIsInN1YiI6IjVlYzdlYTg3ZDIxNDdjMDAyM2JmYTMxYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Tx_AG2kHB0CeETI5SC6pkxE4TtUxZbGtdqZwQpHaYSo"
        UserDefaults.standard.set(apiToken, forKey: "Api_token")

        urlRequest.setValue(apiToken, forHTTPHeaderField: HTTPHeaderConstants.AuthorizationHeaderName)
        return
    }
    
}
