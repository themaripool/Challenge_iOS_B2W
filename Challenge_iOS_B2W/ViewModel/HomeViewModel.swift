//
//  HomeViewModel.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import Foundation
import Alamofire

class HomeViewModel: ObservableObject, Identifiable {

    @Published var pokemonList              : [Pokemon]?
    
    init() {
        getPokemons()
    }
    
    public func reloadData() {
        
    }

    func getPokemons(){
        PokemonService.getAllPokemons { results, error  in
            if results != nil {
                self.pokemonList = results
                print("[DEBUG]: RES = \(String(describing: results))")
                //self.movieView?.setPopularListView(results)
            } else{
                print("[DEBUG] no results")
            }
        }
    }
 
}
extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
