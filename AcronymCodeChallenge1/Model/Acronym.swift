//
//  Acronym.swift
//  AcronymCodeChallenge1
//
//  Created by admin on 24/01/2023.
//

import Foundation

struct Acronym: Decodable {
    let sf: String
    let lfs: [SpecificAcronym]
}

struct SpecificAcronym: Decodable, Identifiable {
    var id = UUID()
    
    let lf: String
    let freq: Int
    let since: Int
    let variations: [Variation]
    
    enum CodingKeys: String, CodingKey {
        case variations = "vars"
        case lf, freq, since
    }
}

struct Variation: Decodable {
    let lf: String
    let freq: Int
    let since: Int
}
