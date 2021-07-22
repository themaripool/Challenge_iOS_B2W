//
//  DetailsViewModel.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import Foundation
import SwiftUI

class DetailsViewModel: ObservableObject{

    @Published var pokemonDetailsList       : Details = Details(id: 0, stats: [], abilities: [], types: [], name: "", species: Species(name: "", url: ""))
    @Published var pokemonAbilityDetails    : AbilityDetail = AbilityDetail(effect_entries: [])
    @Published var pokemonSearched          = Details(id: 0, stats: [], abilities: [], types: [], name: "", species: Species(name: "", url: ""))
    @Published var pokemonEvChain           : spChain = spChain(evolution_chain: Evolution_Chain(url: ""))
    @Published var pokemonChain             : Chain = Chain(chain: EvolvesTo(species: Species(name: "", url: ""), evolves_to: []))
    
    public var SpeciesId = ""
    public var ChainId = ""
    public var ids : [String] = []
    public var names : [String] = []

    var color: Color = Color.white
    
    init() {
        color = getColor()
    }
    
    public func extractAbilityId(urlAbility:String) -> String{
        
        if let range = urlAbility.range(of: "/ability/") {
            let abilityId = urlAbility[range.upperBound...]
            let abId = abilityId.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
            return abId
        }
        return "0"
    }
    
    public func extractSpeciesId(urlSpecies:String) -> String{
        
        if let range = urlSpecies.range(of: "/pokemon-species/") {
            let speciesId = urlSpecies[range.upperBound...]
            let spId = speciesId.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
            return spId
        }
        return "0"
    }
    
    public func extractChainId(urlChain:String) -> String{
        
        if let range = urlChain.range(of: "/evolution-chain/") {
            let chainId = urlChain[range.upperBound...]
            let chId = chainId.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
            return chId
        }
        return "0"
    }
    
    func refreshAbilities(){
        pokemonAbilityDetails = AbilityDetail(effect_entries: [])
    }
    
    func getColor() -> Color {
        
        let type = pokemonDetailsList.types.first?.type.name
                
        switch type {
            case "bug":
                color = Color("Bug")
            case "dark":
                color = Color("Dark")
            case "dragon":
                color = Color("Dragon")
            case "eletric":
                color = Color("Eletric")
            case "fairy":
                color = Color("Fairy")
            case "fighting":
                color = Color("Fighting")
            case "fire":
                color = Color("Fire")
            case "flying":
                color = Color("Flying")
            case "ghost":
                color = Color("Ghost")
            case "grass":
                color = Color("Grass")
            case "ground":
                color = Color("Ground")
            case "ice":
                color = Color("Ice")
            case "normal":
                color = Color("Normal")
            case "poison":
                color = Color("Poison")
            case "psychic":
                color = Color("Psychic")
            case "rock":
                color = Color("Rock")
            case "shadow":
                color = Color("Shadow")
            case "steel":
                color = Color("Steel")
            case "unknown":
                color = Color("Unknown")
            case "water":
                color = Color("Water")
            default:
                color = Color("Background")
        }
        return color
    }
    
    func getPokemonsDetails(index: Int){
        PokemonService.getDetailsPokemons(id: index) { results, error  in
            if results != nil {
                guard let resp = results else {return}
                self.pokemonDetailsList = resp
                self.SpeciesId = self.extractSpeciesId(urlSpecies: resp.species.url)
                print("esp id \(self.SpeciesId)")
                self.getSpecies(id: Int(self.SpeciesId)!)
            } else{
                print("[DEBUG] no results no details")
            }
        }
    }
    
    func getSpecies(id: Int){
        PokemonService.getSpecies(id: id) { results, error  in
            if results != nil {
                guard let resp = results else {return}
                self.pokemonEvChain = resp
                self.ChainId = self.extractChainId(urlChain: resp.evolution_chain.url)
                self.getChain(id: self.ChainId)
            } else{
                print("[DEBUG] no results no species")
            }
        }
    }
    
    func getChain(id: String){
        PokemonService.getEvolutionChain(id: id) { results, error  in
            if results != nil {
                guard let resp = results else {return}
                self.pokemonChain = resp
                dump(resp)
                self.getPokemonsIDInChain(elements: resp)
            } else{
                print("[DEBUG] no results no species")
            }
        }
    }
    
    func getPokemonsIDInChain(elements: Chain){
        
        self.names = []
        self.ids = []
        
        let id = self.extractSpeciesId(urlSpecies: self.pokemonChain.chain.species.url )
        if id != "0" {
            ids.append(id)
            names.append((self.pokemonChain.chain.species.name))
        }
        if !self.pokemonChain.chain.evolves_to.isEmpty {
            let id = self.extractSpeciesId(urlSpecies: self.pokemonChain.chain.evolves_to.first?.species.url ?? "")
            if id != "0" {
                ids.append(id)
                names.append((self.pokemonChain.chain.evolves_to.first?.species.name)!)
            }
            if !self.pokemonChain.chain.evolves_to[0].evolves_to.isEmpty{
                let id = self.extractSpeciesId(urlSpecies: self.pokemonChain.chain.evolves_to[0].evolves_to.first?.species.url ?? "")
                if id != "0" {
                    ids.append(id)
                    names.append((self.pokemonChain.chain.evolves_to[0].evolves_to.first?.species.name)!)
                }
            }
        }
        print(ids)
    }
    
    func getAbilityDetails(index: Int){
        PokemonService.getPokemonAbility(id: index) { results, error  in
            if results != nil {
                self.pokemonAbilityDetails = results
            } else{
                print("[DEBUG] no results no details")
            }
        }
    }
    
    func getPokemonsSearch(search: String){
        PokemonService.getPokemonSearchy(search: search ) { results, error  in
            if results != nil {
                guard let resp = results else {return}
                self.pokemonSearched = resp
            } else{
                print("[DEBUG] no results")
            }
        }
    }
}
