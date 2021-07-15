//
//  ContentView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 13/07/21.
//

import SwiftUI
import Introspect

//MARK: TODO
// Loading quando a lista de pkm esta vazia
// Como eu pego os detalhes com outro request
// Como fazer cacheamento
// Paginacao na lista de home
// Internacionalizacao EN-PT
// API de ibagens


struct ContentView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var pkm = [Pokemon(name: "a", url: "")]

    var body: some View {
        NavigationView {
            List(self.homeViewModel.pokemonList ?? pkm , id: \.self) { item in
                CardListComponent(pokedexNumber: "0", pokemonName: item.name, typeString: ["Grass", "Poison"] )
            }
            //Text("Teste")
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
        ContentView(homeViewModel: HomeViewModel())
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
