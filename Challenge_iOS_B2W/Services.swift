//
//  Services.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import Foundation
import Alamofire

class PokemonService: NSObject {

    static func getAllPokemons(completion: @escaping ([Pokemon], Error?) -> Void){
            let url = "https://pokeapi.co/api/v2/pokemon/"
            
            var pokemonList : [Pokemon] = []
            
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
                        completion([], error)
                        print(error)
                    }
                    
                }
            }
        }
    
    
    static func getDetailsPokemons(id: Int, completion: @escaping (Details, Error?) -> Void){
        
            let url = "https://pokeapi.co/api/v2/pokemon/\(id)/"
            
        var pokemonDetailsList : Details = Details(id: 0, stats: [], abilities: [], types: [], name: "")
            
            AF.request(url).responseData { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        let root = try JSONDecoder().decode(Details.self, from: data)
                        pokemonDetailsList = root
                        completion(pokemonDetailsList, nil)
                    } catch let error {
                        completion(Details(id: 0, stats: [], abilities: [], types: [], name: ""), error)
                        print(error)
                    }
                    
                }
            }
        }
    
    static func getPokemonAbility(id: Int, completion: @escaping (AbilityDetail, Error?) -> Void){
        
        let url = "https://pokeapi.co/api/v2/ability/\(id)/"
            
        var abDetail : AbilityDetail = AbilityDetail(effect_entries: [])
            
            AF.request(url).responseData { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        let root = try JSONDecoder().decode(AbilityDetail.self, from: data)
                        abDetail = root
                        completion(abDetail, nil)
                    } catch let error {
                        completion(AbilityDetail(effect_entries: []), error)
                        print(error)
                    }
                    
                }
            }
        }
    
}





//func loadJSON() {
//    let url = "https://pokeapi.co/api/v2/pokemon/"
//    guard let urlObj = URL(string: url) else { return }
//
//    URLSession.shared.dataTask(with: urlObj) {(data, response, error) in
//        guard let data = data else { return }
//
//        do {
//            let pokedex = try JSONDecoder().decode(Pokedex.self, from: data)
//
//            for pokemon in pokedex.results {
//                guard let jsonURL = pokemon.url else { return }
//                guard let newURL = URL(string: jsonURL) else { return }
//
//                URLSession.shared.dataTask(with: newURL) {(data, response, error) in
//                    guard let data = data else { return }
//
//                    do {
//                        let load = try JSONDecoder().decode(Pokemon.self, from: data)
//                        self.pokemons.append(load)
//                    } catch let jsonErr {
//                        print("Error serializing inner JSON:", jsonErr)
//                    }
//                }.resume()
//            }
//        } catch let jsonErr{
//            print("Error serializing JSON: ", jsonErr)
//        }
//        }.resume()
//}
