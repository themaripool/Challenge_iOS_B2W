//
//  HomeViewModel.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import Foundation
import Alamofire
import Combine
import UIKit
import SwiftUI

class HomeViewModel: ObservableObject, Identifiable {

    @Published var pokemonList                  : [Pokemon] = []
    @Published var nextPage                     : String = ""
    @Published var pokemonListAux               : [Pokemon] = []
    @State var showingAlert: Bool = false
    
    init() {
        getPokemons()
    }
    
    //MARK: Funções para reload de tela
    
    public func reloadData() {
        UIApplication.shared.endEditing()
        pokemonList = []
        if (!pokemonListAux.isEmpty){
            pokemonList = pokemonListAux
            pokemonListAux = []
        }
        self.nextPage = ""
        getPokemons()
    }
    
    //MARK: Funções do load more
    
    public func loadMore() {
        self.loadPokemons(prox: true)
    }
    
    public func loadPokemons(prox: Bool = false) {
        getNextPokemons(pageUrl: nextPage)
    }
    
    //MARK: Funções auxiliares para extrair id das urls
    
    public func extractIdFromPokemon(urlPokemon:String) -> String{
        
        if let range = urlPokemon.range(of: "/pokemon/") {
            let pkmNumber = urlPokemon[range.upperBound...]
            let number = pkmNumber.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
            return number
        }
        return "0"
    }

    //MARK: Serviço
    
    func getPokemons(){
        PokemonService.getAllPokemons { results  in
            switch results {
            case .Success(let list, let url):
                self.nextPage = url
                self.pokemonList = list
            case .Fail(let error):
                print("Error: \(error)")
            }
        }
    }
    
    //MARK: Paginação
    func getNextPokemons(pageUrl: String){
        if pageUrl != "null" {
            PokemonService.getNextAllPokemons(pageUrl: pageUrl) { results in
                switch results {
                case .Success(let list, let url):
                    self.nextPage = url
                    self.pokemonList.append(contentsOf: list)
                case .Fail(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}

