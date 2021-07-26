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

    
    
    static func getDetailsPokemons(id: Int, completion: @escaping (DetailsAPIResp) -> Void){
        
        let url = K.SERVICE.BASE_URL + "\(id)/"
        
        AF.request(url).responseData { response in
            guard let statusCode = response.response?.statusCode else {return}
            switch response.result {
            case .failure(_):
                completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
            case .success(let data):
                switch statusCode {
                
                case 200...307:
                    do {
                        let root = try JSONDecoder().decode(Details.self, from: data)
                        let pokemonDetailsList = root
                        completion(.Success(pokemonDetailsList))
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
    
    static func getPokemonAbility(id: Int, completion: @escaping (AbilityDetailAPIResp) -> Void){
        
        let url = K.SERVICE.ABILITY_URL + "\(id)/"
        
        var abDetail : AbilityDetail = AbilityDetail(effect_entries: [])
        
        AF.request(url).responseData { response in
            guard let statusCode = response.response?.statusCode else {return}
            switch response.result {
            case .failure(_):
                completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
            case .success(let data):
                switch statusCode {
                case 200...307:
                    do {
                        let root = try JSONDecoder().decode(AbilityDetail.self, from: data)
                        abDetail = root
                        completion(.Success(abDetail))
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
    
    static func getSearchedPokemon(search: String, completion: @escaping (DetailsAPIResp) -> Void){
        
        let url = K.SERVICE.BASE_URL + "\(search)/"
        print("\(search) \(url)")
                        
            AF.request(url).responseData { response in
                guard let statusCode = response.response?.statusCode else {return}
                switch response.result {
                case .failure(_):
                    completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
                case .success(let data):
                    switch statusCode {
                    case 200...307:
                        do {
                            let root = try JSONDecoder().decode(Details.self, from: data)
                            let pokemonAux = root
                            completion(.Success(pokemonAux))
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
    
    static func getSpecies(id: Int, completion: @escaping (PokemonSpeciesAPIResp) -> Void){
        
        let url = K.SERVICE.SPECIES_URL + "\(id)/"
        
        AF.request(url).responseData { response in
            guard let statusCode = response.response?.statusCode else {return}
            switch response.result {
            case .failure(_):
                completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
            case .success(let data):
                switch statusCode {
                case 200...307:
                    do {
                        let root = try JSONDecoder().decode(PokemonSpecies.self, from: data)
                        let aux = root
                        completion(.Success(aux))
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
    
    static func getEvolutionChain(id: String, completion: @escaping (ChainAPIResp) -> Void) {
        
        let url = K.SERVICE.EVCHAIN_URL + "\(id)/"
        
        AF.request(url).responseData { response in
    
            guard let statusCode = response.response?.statusCode else {return}
            switch response.result {
            case .failure(_):
                completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
            case .success(let data):
                switch statusCode {
                case 200...307:
                    do {
                        let root = try JSONDecoder().decode(Chain.self, from: data)
                        let aux = root
                        completion(.Success(aux))
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
    
    static func getSameTypesPokemons(id: String, completion: @escaping (SameTypePokemonAPIResp) -> Void){
        
        let url = K.SERVICE.TYPE_URL + "\(id)/"
        
        AF.request(url).responseData { response in
            
            guard let statusCode = response.response?.statusCode else {return}
            switch response.result {
            case .failure(_):
                completion(.Fail(APIError(code: statusCode, message: K.ERROR.DEFAULT)))
            case .success(let data):
                switch statusCode {
                case 200...307:
                    do {
                        let root = try JSONDecoder().decode(SameTypePokemon.self, from: data)
                        let aux = root
                        completion(.Success(aux))
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
    
}
