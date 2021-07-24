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
    @Published var pokemonEvChain           : PokemonSpecies = PokemonSpecies(evolution_chain: Evolution_Chain(url: ""), varieties: [])
    @Published var pokemonChain             : Chain = Chain(chain: EvolvesTo(species: Species(name: "", url: ""), evolves_to: []))
    @Published var pokemonVarietieNameList  : [String] = []
    @Published var pokemonTypesId           : [String] = []
    @Published var sameTypePokemon          : [SameTypePokemonArray] = [SameTypePokemonArray(pokemon: Pokemon(name: "", url: ""))]
    
    public var pokedexNumber = ""
    public var selectedPokemon = ""
    public var SpeciesId = ""
    public var ChainId = ""
    public var ids : [String] = []
    public var names : [String] = []
    public var hasVarieties = false
    public var idsVarieties : [Int] = []

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
    
    public func extractIdFromVariety(urlPokemon:String) -> String{
        
        if let range = urlPokemon.range(of: "/pokemon/") {
            let pkmNumber = urlPokemon[range.upperBound...]
            let number = pkmNumber.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
            return number
        }
        return "0"
    }
    
    public func extractTypeId(urlPokemon:String) -> String{
        
        if let range = urlPokemon.range(of: "/type/") {
            let pkmTypeNumber = urlPokemon[range.upperBound...]
            let type = pkmTypeNumber.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
            return type
        }
        return "0"
    }
    
    func refresh(){
        self.pokemonDetailsList       = Details(id: 0, stats: [], abilities: [], types: [], name: "", species: Species(name: "", url: ""))
        self.pokemonAbilityDetails    = AbilityDetail(effect_entries: [])
        self.pokemonSearched          = Details(id: 0, stats: [], abilities: [], types: [], name: "", species: Species(name: "", url: ""))
        self.pokemonEvChain           = PokemonSpecies(evolution_chain: Evolution_Chain(url: ""), varieties: [])
        self.pokemonChain             = Chain(chain: EvolvesTo(species: Species(name: "", url: ""), evolves_to: []))
        self.pokemonVarietieNameList  = []
        self.pokemonTypesId           = []
        self.sameTypePokemon          = [SameTypePokemonArray(pokemon: Pokemon(name: "", url: ""))]
        
        self.pokedexNumber = ""
        self.selectedPokemon = ""
        self.SpeciesId = ""
        self.ChainId = ""
        self.ids  = []
        self.names = []
        self.hasVarieties = false
        self.idsVarieties  = []
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
    
    //MARK: Set Variables
    func setVariables(number: String, selected: String){
        self.pokedexNumber = number
        self.selectedPokemon = selected
    }
    
    //MARK: Aux Functions
    
    func getPokemonsIDInChain(elements: Chain){
        
        self.names = []
        self.ids = []
        
        let id = self.extractSpeciesId(urlSpecies: self.pokemonChain.chain.species.url )
        if id != "0" {
            ids.append(id)
            names.append((self.pokemonChain.chain.species.name))
        }
        for element in self.pokemonChain.chain.evolves_to {
            
            let id = self.extractSpeciesId(urlSpecies: element.species.url)
            if id != "0" {
                ids.append(id)
                names.append((element.species.name))
            }
            if !element.evolves_to.isEmpty {
                let id = self.extractSpeciesId(urlSpecies: element.evolves_to.first?.species.url ?? "")
                if id != "0" {
                    ids.append(id)
                    names.append((element.evolves_to.first?.species.name)!)
                }
            }
        }
        print(ids)
    }
    
    func getVarietiesIds(varieties: [Varieties]){
        self.idsVarieties = []
        self.pokemonVarietieNameList = []
        for variety in varieties {
            let id = self.extractIdFromVariety(urlPokemon: variety.pokemon.url)
            self.pokemonVarietieNameList.append(variety.pokemon.name)
            guard let intId = Int(id) else { return }
            idsVarieties.append(intId)
        }
    }
    
    //MARK: Services Functions
    
    func getPokemonsDetails(index: Int){
        PokemonService.getDetailsPokemons(id: index) { results, error  in
            if results != nil {
                guard let resp = results else {return}
                self.pokemonDetailsList = resp
                self.SpeciesId = self.extractSpeciesId(urlSpecies: resp.species.url)
                self.getSpecies(id: Int(self.SpeciesId)!)
                for element in resp.types {
                    let id =  self.extractTypeId(urlPokemon: element.type.url)
                    self.pokemonTypesId.append(id)
                }
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
                self.hasVarieties = resp.varieties.count > 1 ? true :  false
                self.getVarietiesIds(varieties:  resp.varieties)
            } else{
                print("[DEBUG] no results no species")
            }
        }
    }
    
    func findIndexInArray(name: String) -> Int {
        for index in pokemonVarietieNameList.indices {
            let aux = pokemonVarietieNameList[index]
            if aux == name{
                return index
            }
        }
        return -1
    }
    
    func getChain(id: String){
        PokemonService.getEvolutionChain(id: id) { results, error  in
            if results != nil {
                guard let resp = results else {return}
                self.pokemonChain = resp
                self.getPokemonsIDInChain(elements: resp)
            } else{
                print("[DEBUG] no results no species")
            }
        }
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
    
    //MARK: Funcao que usa o id para pegar os pokemons que possuem o mesmo tipo que o tipo selecionado
    func getSameTypePokemons(id: String){
        print("Pegando pokemons com id = \(id)")
        PokemonService.getSameTypesPokemons(id: id) { results, error  in
            if results != nil {
                guard let resp = results else {return}
                self.sameTypePokemon = resp.pokemon
            } else{
                print("[DEBUG] no results")
            }
        }
    }
}
