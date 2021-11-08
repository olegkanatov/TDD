//
//  APIClient.swift
//  TDDApp
//
//  Created by Oleg Kanatov on 8.11.21.
//

import Foundation

protocol URLSessionProtocol{
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class APIClient {
    
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    func login(withName: String, password: String, complitionHandler: @escaping (String?, Error?) -> Void) {
        
        guard let url = URL(string: "https://todoapp.com/login") else { fatalError() }
        
        urlSession.dataTask(with: url) { data, responce, error in
            
        }.resume()
    }
}
