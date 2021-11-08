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
    
    func login(withName name: String, password: String, complitionHandler: @escaping (String?, Error?) -> Void) {
        
        let allowedCharacters = CharacterSet.urlQueryAllowed
        
        guard let name = name.addingPercentEncoding(withAllowedCharacters: allowedCharacters),
              let password = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
                  fatalError()
              }
        
        let query = "name=\(name)&password=\(password)"
        
        guard let url = URL(string: "https://todoapp.com/login?\(query)") else { fatalError() }
        
        urlSession.dataTask(with: url) { data, responce, error in
            
            guard let data = data else { fatalError() }
            let dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : String]
            
            let token = dictionary["token"]
            complitionHandler(token, nil)
        }.resume()
    }
}
