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

    @Published var pokemonList                  : [Pokemon] = []
    @Published var nextPage                     : String = ""
    @Published var pokemonListAux               : [Pokemon] = []
    
    init() {
        getPokemons()
        //bug na volta do dismiss, talvez esteja relacionado ao fato do pokemon list n estar vazio
    }
    
    public func reloadData() {
        pokemonList = []
        pokemonList = pokemonListAux
        pokemonListAux = []
    }
    
    public func loadMore() {
        self.loadPokemons(prox: true)
    }
    
    public func loadPokemons(prox: Bool = false) {
        getNextPokemons(pageUrl: nextPage)
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
        PokemonService.getAllPokemons { results, page, error  in
            if results != [] {
                self.nextPage = page
                self.pokemonList = results
            } else{
                print("[DEBUG] no results")
            }
        }
    }
    func getNextPokemons(pageUrl: String){
        PokemonService.getNextAllPokemons(pageUrl: pageUrl) { results, page, error  in
            if results != [] {
                self.nextPage = page
                self.pokemonList.append(contentsOf: results)
            } else{
                print("[DEBUG] no results")
            }
        }
    }
}

