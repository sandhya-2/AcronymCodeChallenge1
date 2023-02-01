//
//  AcronymRepository.swift
//  AcronymCodeChallenge1
//
//  Created by admin on 30/01/2023.
//

import Foundation


protocol AcronymListRepository {
    func getAcronyms(acronym: String, completion: @escaping (Result<[Acronym], Error>) -> Void)
}

final class AcronymListRepositoryImplementation {
    
    private let networkManager: Network
    
    init(networkManager: Network) {
        self.networkManager = networkManager
    }
    
    var dispatchNetworkTask: DispatchWorkItem? {
        didSet {
            if let oldTask = oldValue { oldTask.cancel() }
            guard let task = self.dispatchNetworkTask else { return }
            DispatchQueue.global().asyncAfter(deadline: .now()+1, execute: task)
        }
    }
}

extension AcronymListRepositoryImplementation: AcronymListRepository {

    func getAcronyms(acronym: String, completion: @escaping (Result<[Acronym], Error>) -> Void) {
        guard !acronym.isEmpty else {

            self.dispatchNetworkTask = nil
            return
        }
        
        self.dispatchNetworkTask = DispatchWorkItem {
            self.networkManager.getModel(request: NetworkParams.acronymSearch(acronym).urlRequest) {  (result: Result<[Acronym], Error>) in
                switch result {
                case .success(let result):
                    // true success
//                    if let value = result.first {
                        // true success
                        completion(.success(result))
//                    } else {
//                        completion(.failure(NetworkError.emptyResult))
//                    }
                    
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
        }
    }
        
}
