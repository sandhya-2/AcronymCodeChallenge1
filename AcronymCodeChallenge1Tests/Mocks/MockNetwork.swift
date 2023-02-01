//
//  MockNetwork.swift
//  AcronymCodeChallenge1Tests
//
//  Created by admin on 24/01/2023.
//

import Foundation
@testable import AcronymCodeChallenge1

class MockNetworkManager: Network {
    

    func getModel<T>(request: URLRequest?, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        guard let url = request?.url else {
            completion(.failure(NetworkError.badRequest))
            return
        }
        
        switch url.absoluteString {
        case _ where url.absoluteString.contains(NetworkError.emptyResult.urlTest):
            guard let model = [] as? T else { return }
            completion(.success(model))
            return
        case _ where url.absoluteString.contains(NetworkError.badServerResponse(404).urlTest):
            completion(.failure(NetworkError.badServerResponse(404)))
            return
        case _ where url.absoluteString.contains(NetworkError.badRequest.urlTest):
            completion(.failure(NetworkError.badRequest))
            return
        case _ where url.absoluteString.contains(NetworkError.missingData.urlTest):
            completion(.failure(NetworkError.missingData))
            return
        default:
            guard let model = [Acronym(sf: "DOE", lfs: [SpecificAcronym(lf: "Department of Energy", freq: 5, since: 1981, variations: [Variation(lf: "", freq: 0, since: 0)])])] as? T else { return }
            completion(.success(model))
            return
        }
        
    }
    
}
