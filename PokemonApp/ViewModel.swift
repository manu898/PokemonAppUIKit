//
//  ViewModel.swift
//  Interview
//
//  Created by Manuel Caparrelli on 11/04/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon]? {
        didSet {
            guard oldValue != pokemonList else { return }
            homeVC?.pokemonList = pokemonList
        }
    }
    
    weak var homeVC: HomeViewController?
    
    private let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    func getPokemonList(query: [String: Any]) async throws {
        do {
            let receivedPokemons: PokemonResult = try await ApiCaller.shared.performApiRequest(query: query, baseURL: baseURL)
            
            for i in 0..<receivedPokemons.results.count {
                let pokemon = try await getPokemon(id: receivedPokemons.results[i].name)
                pokemonList?.append(pokemon)
            }
        }
        catch {
            throw error
        }
    }
    
    func getPokemon(id: Any) async throws -> Pokemon {
        do {
            let receivedPokemon: Pokemon = try await ApiCaller.shared.performApiRequest(query: "\(id)/", baseURL: baseURL)
            return receivedPokemon
        }
        catch {
            throw error
        }
    }
    
    func favoriteAction(pokemon: Pokemon) {
        let pokemonIndex = pokemonList?.firstIndex(where: { $0.name == pokemon.name })
        if let pokemonIndex = pokemonIndex, var pokemonNew = pokemonList?[pokemonIndex] {
            pokemonNew.inFavorites = !(pokemonNew.inFavorites)
            pokemonList?[pokemonIndex] = pokemonNew
        }
    }
    
    //    func makeRequest(isPagination: Bool, completion: @escaping (Result<[String], Error>) -> Void){
    //        if isPagination {
    //            isPaginationOn = true
    //        }
    //        DispatchQueue.global().asyncAfter(deadline: .now() + (isPagination ? 2 : 3), execute: {
    //
    //            completion(.success(isPagination ? nextData : data))
    //            if isPagination {
    //                self.isPaginationOn = false
    //            }
    //        })
    //    }
}
