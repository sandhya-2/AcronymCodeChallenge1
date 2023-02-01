//
//  FakeNetworkManager.swift
//  AcronymCodeChallenge1Tests
//
//  Created by admin on 31/01/2023.
//

import Foundation
@testable import AcronymCodeChallenge1

class FakeNetworkManager: Network {
    
    var session: AcronymCodeChallenge1.Session = URLSession.shared
    
    
    func getModel<T: Decodable>(request: URLRequest?, completion: @escaping (Result<T, Error>) -> Void) {
            do {
                let bundle = Bundle(for: FakeNetworkManager.self)
                guard let path =  bundle.url(forResource:request?.url?.absoluteString, withExtension: "json") else {
                    completion(.failure(NetworkError.badRequest))
                    return
                }
                
                let data = try Data(contentsOf: path)
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
                
            } catch {
                completion(.failure(NetworkError.missingData))
            }
        }
}
