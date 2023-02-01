//
//  AcronymViewModelType.swift
//  AcronymCodeChallenge1
//
//  Created by admin on 24/01/2023.
//

import Foundation

protocol AcronymViewModelType {
    var result: Acronym? { get }
    func bind(successBinding: @escaping () -> Void, failureBinding: @escaping (Error) -> Void)
    func searchAcronym(acronym: String)
    var count: Int { get }
    func fullForm(for index: Int) -> String?
}

typealias SuccessBinding = () -> Void
typealias FailureBinding = (Error) -> Void

class AcronymViewModel:ObservableObject, AcronymViewModelType {
    
    private let repository: AcronymListRepository
    @Published var error: NetworkError?
    
    @Published var searchText: String = "" {
        didSet {
            if searchText.count > 1 {
                self.searchAcronym(acronym: searchText)
            }
        }
    }
    
    var result: Acronym? {
        didSet {
            self.successBinding?()
        }
    }
    
    private var successBinding: SuccessBinding?
    private var failureBinding: FailureBinding?
    
    init(repository: AcronymListRepository) {
        self.repository = repository
        
    }
    
    func bind(successBinding: @escaping () -> Void, failureBinding: @escaping (Error) -> Void) {
        self.successBinding = successBinding
        self.failureBinding = failureBinding
    }
    
    func searchAcronym(acronym: String) {
        guard !acronym.isEmpty else {
            return
        }
        repository.getAcronyms(acronym: acronym) {
            [weak self] (result: Result<[Acronym], Error>) in
            switch result {
            case .success(let result):
                // decode sucess
                if let value = result.first {
                    // true success
                    DispatchQueue.main.async {
                        self?.result = value
                        self?.error = nil
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self?.error = NetworkError.emptyResult
                        self?.result = nil
                        self?.failureBinding?(NetworkError.emptyResult)
                    }
                    
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self?.error = NetworkError.missingData
                    self?.failureBinding?(NetworkError.missingData)
                    self?.result = nil
                }
                
                
            }
        }
    }

    var count: Int {
        return self.result?.lfs.count ?? 0
    }
    
    func fullForm(for index: Int) -> String? {
        guard index < count else { return nil }
        return self.result?.lfs[index].lf
    }

}

