//
//  Services.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import Foundation
import Alamofire

class PokemonService: NSObject {

    static func getAllPokemons(completion: @escaping (PokemonList) -> Void){
        let url = K.SERVICE.BASE_URL
        
        var pokemonList : [Pokemon] = []
        var nextPage = ""
        
        AF.request(url).responseData { response in
            guard let statusCode = response.response?.statusCode else {return}
            switch response.result {
            case .failure(_):
                completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
            case .success(let data):
                switch statusCode {
                case 200...307:
                    do {
                        let root = try JSONDecoder().decode(Root.self, from: data)
                        pokemonList = root.results
                        nextPage = root.next
                        completion(.Success(pokemonList, nextPage))
                    } catch _ {
                        completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
                    }
                case 404:
                    completion(.Fail(APIError(code: statusCode, message: K.ERROR.EMPTY_CONTENT)))
                case 429:
                    completion(.Fail(APIError(code: statusCode, message: K.ERROR.TOO_MANY_REQUESTS)))
                default:
                    completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
                }
            }
        }
    }
    
    static func getNextAllPokemons(pageUrl: String, completion: @escaping (PokemonList) -> Void){
        
        var pokemonList : [Pokemon] = []
        var nextPage = ""
        
        AF.request(pageUrl).responseData { response in
            guard let statusCode = response.response?.statusCode else {return}
            switch response.result {
            case .failure(_):
                completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
            case .success(let data):
                switch statusCode {
                    case 200...307:
                        do {
                            let root = try JSONDecoder().decode(Root.self, from: data)
                            pokemonList = root.results
                            nextPage = root.next
                            completion(.Success(pokemonList, nextPage))
                        } catch let error {
                            completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
                            print(error)
                        }
                    case 404:
                        completion(.Fail(APIError(code: statusCode, message: K.ERROR.EMPTY_CONTENT)))
                    case 429:
                        completion(.Fail(APIError(code: statusCode, message: K.ERROR.TOO_MANY_REQUESTS)))
                    default:
                        completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
                }
                
            }
        }
    }

    
    
    static func getDetailsPokemons(id: Int, completion: @escaping (Details?, Error?) -> Void){
        
        let url = K.SERVICE.BASE_URL + "\(id)/"
            
            AF.request(url).responseData { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        let root = try JSONDecoder().decode(Details.self, from: data)
                        let pokemonDetailsList = root
                        completion(pokemonDetailsList, nil)
                    } catch let error {
                        completion(nil, error)
                        print(error)
                    }
                    
                }
            }
        }
    
    static func getPokemonAbility(id: Int, completion: @escaping (AbilityDetail, Error?) -> Void){
        
        let url = K.SERVICE.ABILITY_URL + "\(id)/"
            
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
    
    static func getSearchedPokemon(search: String, completion: @escaping (Details?, Error?) -> Void){
        
        let url = K.SERVICE.BASE_URL + "\(search)/"
        print("\(search) \(url)")
                        
            AF.request(url).responseData { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        let root = try JSONDecoder().decode(Details.self, from: data)
                        let pokemonAux = root
                        completion(pokemonAux, nil)
                    } catch let error {
                        completion(nil, error)
                        print(error)
                    }
                    
                }
            }
        }
    
    static func getSpecies(id: Int, completion: @escaping (PokemonSpecies?, Error?) -> Void){
        
        let url = K.SERVICE.SPECIES_URL + "\(id)/"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    let root = try JSONDecoder().decode(PokemonSpecies.self, from: data)
                    let aux = root
                    completion(aux, nil)
                } catch let error {
                    completion(nil, error)
                    print(error)
                }
                
            }
        }
    }
    
    static func getEvolutionChain(id: String, completion: @escaping (Chain?, Error?) -> Void){
        
        let url = K.SERVICE.EVCHAIN_URL + "\(id)/"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    let root = try JSONDecoder().decode(Chain.self, from: data)
                    let aux = root
                    completion(aux, nil)
                } catch let error {
                    completion(nil, error)
                    print(error)
                }
                
            }
        }
    }
    
    static func getSameTypesPokemons(id: String, completion: @escaping (SameTypePokemon?, Error?) -> Void){
        
        let url = K.SERVICE.TYPE_URL + "\(id)/"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    let root = try JSONDecoder().decode(SameTypePokemon.self, from: data)
                    let aux = root
                    completion(aux, nil)
                } catch let error {
                    completion(nil, error)
                    print(error)
                }
                
            }
        }
    }
    
}
