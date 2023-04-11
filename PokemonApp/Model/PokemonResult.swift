//
//  PokemonResult.swift
//  Interview
//
//  Created by Manuel Caparrelli on 11/04/23.
//

import Foundation

// MARK: - Pokemon
struct PokemonResult: Codable {
    let id: Int?
    let results: [ResultPokemon]
    let next: String?
    let previous: String?
}

// MARK: - Result
struct ResultPokemon: Codable, Hashable {
    let name: String
    let url: String
}
