//
//  HomeViewModel.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import Foundation
import Alamofire
import Combine

class HomeViewModel: ObservableObject, Identifiable {

    @Published var pokemonList              : [Pokemon] = []
    
    init() {
        getPokemons()
    }
    
    public func reloadData() {
        
    }
    
    public func loadMore() {
        self.loadPokemons(nextPage: true)
    }
    
    public func loadPokemons(nextPage: Bool = false) {
        
        
    }
    
    public func extractIdFromPokemon(urlPokemon:String) -> String{
        
        if let range = urlPokemon.range(of: "/pokemon/") {
            let pkmNumber = urlPokemon[range.upperBound...]
            let number = pkmNumber.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
            return number
        }
        return "0"
    }

    //MARK: Services calls
    func getPokemons(){
        PokemonService.getAllPokemons { results, error  in
            if results != [] {
                self.pokemonList = results
            } else{
                print("[DEBUG] no results")
            }
        }
    }
}

