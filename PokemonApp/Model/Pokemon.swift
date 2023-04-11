//
//  Pokemon.swift
//  Interview
//
//  Created by Manuel Caparrelli on 11/04/23.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable, Hashable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let abilities: [Ability]?
    let baseExperience: Int?
    let id: Int?
    let name: String?
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]?
    var inFavorites: Bool = false

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case id
        case name
        case species, sprites, stats
    }
}

// MARK: - Ability
struct Ability: Codable {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String?
    let url: String?
}

// MARK: - Sprites
class Sprites: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int?
    let stat: Species?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

