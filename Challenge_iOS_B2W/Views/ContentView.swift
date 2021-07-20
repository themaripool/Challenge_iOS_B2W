//
//  ContentView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 13/07/21.
//

import SwiftUI


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
            if homeViewModel.pokemonList.isEmpty {
                
                HomeLoadingView()
                
            }else{
                List {
                    pokemonList
                }
                .navigationBarTitle("Pokedex")
                .navigationBarItems(trailing:
                    Button(action: {
                        print("search button was tapped")}
                    ) {
                    Image(systemName: "magnifyingglass")
                    }
                )
            }
        }
    }
    
    var pokemonList: some View {
        return Group {
            ForEach(self.homeViewModel.pokemonList.indices, id: \.self) { index in
                
                let pokemon = self.homeViewModel.pokemonList[index]
                let id = self.homeViewModel.extractIdFromPokemon(urlPokemon: pokemon.url)
                
                CardListComponent(detailsViewModel: DetailsViewModel(), pokedexNumber: id, pokemonName: pokemon.name, index: index + 1)
                    .onAppear {
                        if self.homeViewModel.pokemonList.last == pokemon {
                            print("ultimo")
                            //self.newsViewModel.loadMore()
                        }
                    }
            }.listRowBackground(Color.init("Background"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(homeViewModel: HomeViewModel())
    }
}
