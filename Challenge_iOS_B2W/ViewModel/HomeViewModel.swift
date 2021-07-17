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
    //@Published var pokemonDetailsList       :Details?//: [Details]?
    
    init() {
        getPokemons()
        //getPokemonsDetails()
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
            let phone = urlPokemon[range.upperBound...]
            var num = phone.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
            print("testeee \(num)")
            return num
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
    
//    func getPokemonsDetails(index: Int){
//        PokemonService.getDetailsPokemons(id: 1) { results, error  in
//            if results != nil {
//                self.pokemonDetailsList = results
//                print("[DEBUG]: RES = \(String(describing: results))")
//                //self.movieView?.setPopularListView(results)
//            } else{
//                print("[DEBUG] no results no details")
//            }
//        }
//    }
 
}
extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
