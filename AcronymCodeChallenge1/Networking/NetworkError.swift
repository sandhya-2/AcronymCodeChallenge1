//
//  NetworkError.swift
//  AcronymCodeChallenge1
//
//  Created by admin on 24/01/2023.
//

import Foundation

enum NetworkError: Error, Equatable {
    case missingData
    case badServerResponse(Int)
    case badRequest
    case emptyResult
}
