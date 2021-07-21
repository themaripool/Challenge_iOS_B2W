//
//  DetailsViewModel.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import Foundation
import SwiftUI

class DetailsViewModel: ObservableObject{

    @Published var pokemonDetailsList       : Details = Details(id: 0, stats: [], abilities: [], types: [], name: "")
    @Published var pokemonAbilityDetails    : AbilityDetail = AbilityDetail(effect_entries: [])
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
                self.pokemonDetailsList = results
               // print("[DEBUG]: RES = \(String(describing: results))")
                //self.movieView?.setPopularListView(results)
            } else{
                print("[DEBUG] no results no details")
            }
        }
    }
    
    func getAbilityDetails(index: Int){
        PokemonService.getPokemonAbility(id: index) { results, error  in
            if results != nil {
                self.pokemonAbilityDetails = results
                print("[DEBUG]: RES = \(String(describing: results))")
                //self.movieView?.setPopularListView(results)
            } else{
                print("[DEBUG] no results no details")
            }
        }
    }
}
