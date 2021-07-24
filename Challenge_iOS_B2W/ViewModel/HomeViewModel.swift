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
        if (!pokemonListAux.isEmpty){ //eh uma busca
            print("[BUG - RELOAD HOME]: reload de search")
            pokemonList = pokemonListAux
            pokemonListAux = []
        }
        print("[BUG - RELOAD HOME]: reload normal")
        self.nextPage = ""
        getPokemons()
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
        print("[BUG - RELOAD HOME]: Entrou em get pokemons")
        self.pokemonList = []
        PokemonService.getAllPokemons { results, page, error  in
            if results != [] {
                print("[BUG - RELOAD HOME]: results n eh vazio")
                self.nextPage = page
                print("[BUG - RELOAD HOME]: next page = \(self.nextPage)")
                self.pokemonList = results
                dump(results)
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

