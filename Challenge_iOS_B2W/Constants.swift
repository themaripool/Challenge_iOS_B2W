//
//  Constants.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 25/07/21.
//

import Foundation

struct K {
    struct SERVICE {
        static let BASE_URL             = "https://pokeapi.co/api/v2/pokemon/"
        static let ABILITY_URL          = "https://pokeapi.co/api/v2/ability/"
        static let SPECIES_URL          = "https://pokeapi.co/api/v2/pokemon-species/"
        static let EVCHAIN_URL          = "https://pokeapi.co/api/v2/evolution-chain/"
        static let TYPE_URL             = "https://pokeapi.co/api/v2/type/"
        
    }
    public struct ERROR {
        static let TOO_MANY_REQUESTS    = "Server Error: Too many requests"
        static let EMPTY_CONTENT        = "Server Error: Empty Content"
        static let DEFAULT              = "Server Error"
        static let INTERNAL             = "Server Error: Internal Error"
        static let CONNECTION           = "Internet Connection Error"
    }
    struct REQUEST {
        static let SUCCESS_STATUS_CODE              = 200...307
        static let EMPTY_CONTENT_STATUS_CODE        = 404
        static let TOO_MANY_REQUEST_STATUS_CODE     = 429
        static let INTERNAL_ERROR_STATUS_CODE       = 400...599
    }
}

struct APIError {
    let code: Int
    let message: String
}

enum PokemonList {
    case Success([Pokemon], String)
    case Fail(APIError)
}

enum DetailsAPIResp {
    case Success(Details)
    case Fail(APIError)
}

enum AbilityDetailAPIResp{
    case Success(AbilityDetail)
    case Fail(APIError)
}

enum PokemonSpeciesAPIResp{
    case Success(PokemonSpecies)
    case Fail(APIError)
}

enum ChainAPIResp{
    case Success(Chain)
    case Fail(APIError)
}

enum SameTypePokemonAPIResp{
    case Success(SameTypePokemon)
    case Fail(APIError)
}
