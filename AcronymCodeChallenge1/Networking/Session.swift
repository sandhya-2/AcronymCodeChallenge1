//
//  Session.swift
//  AcronymCodeChallenge1
//
//  Created by admin on 24/01/2023.
//

import Foundation

protocol Session {
    func requestData(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: Session {
    
    func requestData(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        self.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    
}
