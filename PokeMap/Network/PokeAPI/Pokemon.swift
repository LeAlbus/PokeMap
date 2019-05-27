//
//  Pokemon.swift
//  PokeMap
//
//  Created by Pedro Lopes on 05/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation

struct Pokemon: Decodable{
    
    let name: String
    let url: String
    
    private enum CodingKeys: String, CodingKey{
        case name
        case url
    }
}

struct PokemonList: Decodable {
    
    let results: [Pokemon]
    
    private enum CodingKeys: String, CodingKey{
        case results
    }
}

struct CapturedPoke: Encodable {
    
    let number: Int
    let quantity: Int
}

struct CapturedList: Encodable {
    
    let list: [CapturedPoke]
}

struct PokeInfo: Codable {
    
    let name: String
    let number: Int
    let weight: Int
    let height: Int
    
    private enum CodingKeys: String, CodingKey{
        case name
        case number = "id"
        case weight
        case height
    }
}
