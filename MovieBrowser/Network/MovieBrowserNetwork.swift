//
//  MovieBrowserNetwork.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-23.
//

import Foundation
import Alamofire

public class MovieBrowserNetwork{
    
    static let sharedInstance = MovieBrowserNetwork()
    
    private let sessionManager: SessionManager
    
    init() {
        
        let requestAdapter = MovieBrowserRequestAdapter()
        
        self.sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        self.sessionManager.adapter = requestAdapter
    }
    
    @discardableResult
    public func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> DataRequest {
        return sessionManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
    

    @discardableResult
    public func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest)
    }
    
    #if !os(watchOS)
    
    // MARK: - Stream Request
    
    // MARK: Hostname and Port
    
    /// Creates a `StreamRequest` using the default `SessionManager` for bidirectional streaming with the `hostname`
    /// and `port`.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter hostName: The hostname of the server to connect to.
    /// - parameter port:     The port of the server to connect to.
    ///
    /// - returns: The created `StreamRequest`.
    @discardableResult
    @available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
    public func stream(withHostName hostName: String, port: Int) -> StreamRequest {
        return sessionManager.stream(withHostName: hostName, port: port)
    }
    
    // MARK: NetService
    
    /// Creates a `StreamRequest` using the default `SessionManager` for bidirectional streaming with the `netService`.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter netService: The net service used to identify the endpoint.
    ///
    /// - returns: The created `StreamRequest`.
    @discardableResult
    @available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
    public func stream(with netService: NetService) -> StreamRequest {
        return sessionManager.stream(with: netService)
    }
    
    #endif

}
