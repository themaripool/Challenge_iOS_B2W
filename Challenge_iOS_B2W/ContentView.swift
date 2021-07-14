//
//  ContentView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 13/07/21.
//

import SwiftUI
import Introspect

struct Pokemon: Identifiable {
    var name: String
    var id: String
    var types: [String]
    
}

struct ContentView: View {
    
    var pokemonList = [
        Pokemon(name: "Bulbasauro", id: "#001", types: ["Grass", "Poison"]),
        Pokemon(name: "Ivysaur", id: "#002", types: ["Grass", "Poison"]),
        Pokemon(name: "Venusaur", id: "#003", types: ["Grass", "Poison"]),
        Pokemon(name: "Charmander", id: "#004", types: ["Fire"]),
        Pokemon(name: "Squirtle", id: "#007", types: ["Water"])
        
    ]
    
    var body: some View {
        NavigationView {
            List(pokemonList) { item in
                CardListComponent(pokedexNumber: item.id, pokemonName: item.name, typeString: item.types)
            }
            //.removeBackground()
            .navigationBarTitle("Pokedex")
            .navigationBarItems(trailing:
                Button(action: {
                    print("Edit button was tapped")}
                ) {
                Image(systemName: "magnifyingglass")
                }
            )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension List {
  /// List on macOS uses an opaque background with no option for
  /// removing/changing it. listRowBackground() doesn't work either.
  /// This workaround works because List is backed by NSTableView.
  func removeBackground() -> some View {
    return introspectTableView { tableView in
      tableView.backgroundColor = .clear
    }
  }
}
