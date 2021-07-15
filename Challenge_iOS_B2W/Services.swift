//
//  Services.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import Foundation
import Alamofire

class PokemonService: NSObject {

    static func getAllPokemons(completion: @escaping ([Pokemon]?, Error?) -> Void){
            let url = "https://pokeapi.co/api/v2/pokemon/"
            
            var pokemonList : [Pokemon]?
            
            AF.request(url).responseData { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        let root = try JSONDecoder().decode(Root.self, from: data)
                        pokemonList = root.results
                        completion(pokemonList, nil)
                    } catch let error {
                        completion(nil, error)
                        print(error)
                    }
                    
                }
            }
        }
    
}
