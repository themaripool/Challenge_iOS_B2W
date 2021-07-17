//
//  DetailsViewModel.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import Foundation
class DetailsViewModel: ObservableObject{

    @Published var pokemonDetailsList  :Details = Details(id: 0, stats: [], abilities: [], types: [])
    
    init() {
       // getPokemonsDetails(index: 1)
    }
    
    func getPokemonsDetails(index: Int){
        PokemonService.getDetailsPokemons(id: index) { results, error  in
            if results != nil {
                self.pokemonDetailsList = results
                print("[DEBUG]: RES = \(String(describing: results))")
                //self.movieView?.setPopularListView(results)
            } else{
                print("[DEBUG] no results no details")
            }
        }
    }
}
