//
//  Pokemon.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import Foundation

struct Root : Decodable {
    let count               : Int
    let next                : String
    let results             : [Pokemon]
}

struct Pokemon: Codable, Hashable {
    var name                : String
    var url                 : String
}
struct Details: Codable {
    var id                  : Int
    var stats               : [Stats]
    var abilities           : [Abilities]
    var types               : [Types]
    var name                : String
    var species             : Species
}

//detalhes insere a url da especie
// dentro de specie tem o id da especie - preciso pegar o id da url pra tacar no enpoint do especie //ok
// dentro do endpoint da specie tem o evolution chain - url com id // ok
// pegar o id e tacar no endpointo do evolution chain

struct Species: Codable {
    var name                : String
    var url                 : String // evolution chain
}

struct spChain: Codable {
    var evolution_chain     : Evolution_Chain
}

struct Evolution_Chain: Codable {
    var url                 : String
}

struct Chain: Codable {
    var chain               : EvolvesTo
}

struct EvolvesTo: Codable{
    var species             : Species
    var evolves_to          : [Evolution]
}

struct Evolution: Codable {
    var species             : Species
    var evolves_to          : [Evolution]
}

struct Stats: Codable {
    var base_stat           : Int
    var effort              : Int
    var stat                : Stat
    
}

struct Stat: Codable {
    var name                : String
    var url                 : String
}

struct Abilities : Codable {
    var ability             : Ability
    var is_hidden           : Bool
    var slot                : Int
}

struct Ability : Codable {
    var name                : String
    var url                 : String
}

struct AbilityDetail: Codable {
    var effect_entries      : [AbilityDescription]
}

struct AbilityDescription: Codable {
    var effect              : String
    var language            : AbilityDescriptionLanguage
}

struct AbilityDescriptionLanguage : Codable {
    var name                : String
    var url                 : String
}

struct Types : Codable {
    var slot                : Int
    var type                : Type
}

struct Type : Codable {
    var name                : String
    var url                 : String
}
