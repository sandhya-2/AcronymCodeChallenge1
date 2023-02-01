//
//  NetworkManager.swift
//  AcronymCodeChallenge1
//
//  Created by admin on 24/01/2023.
//

import Foundation

protocol Network {
    func getModel<T: Decodable>(request: URLRequest?, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkManager: Network {
    
    var session: Session
    
    init(session: Session = URLSession.shared) {
        self.session = session
    }
    
    func getModel<T: Decodable>(request: URLRequest?, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let request = request else {
            completion(.failure(NetworkError.badRequest))
            return
        }
        
        self.session.requestData(request: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badServerResponse(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.missingData))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        
        return
    }
    
}
