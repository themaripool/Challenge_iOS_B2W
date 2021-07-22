//
//  ContentView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 13/07/21.
//

import SwiftUI
import UIKit
import Foundation

struct ContentView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var detailsViewModel: DetailsViewModel
    @State private var searchText: String = ""
    
    var pkm = [Pokemon(name: "a", url: "")]

    var body: some View {
        NavigationView {
            if homeViewModel.pokemonList.isEmpty {
                
                HomeLoadingView()
                
            }else{
               
                List {
                    SearchBar(text: $searchText, detailsViewModel: detailsViewModel, homeViewModel: homeViewModel)
                    pokemonList
                }.onAppear(){
                    searchText = ""
                }
                .navigationBarTitle("Pokedex")
            }
        }
    }
    
    var pokemonList: some View {
        return Group {
            ForEach(self.homeViewModel.pokemonList.indices, id: \.self) { index in
                
                let pokemon = self.homeViewModel.pokemonList[index]
                let id = self.homeViewModel.extractIdFromPokemon(urlPokemon: pokemon.url)
                
               // var _ = print("index \(index) e id \(id) e url \(pokemon.url)")
                
                CardListComponent(detailsViewModel: DetailsViewModel(), pokedexNumber: id, pokemonName: pokemon.name, index: index + 1).environmentObject(homeViewModel)
                    .onAppear {
                        if self.homeViewModel.pokemonList.last == pokemon {
                            print("ultimo")
                            //self.homeViewModel.loadMore() -> n espera chegar no ultimo
                        }
                    }
            }.listRowBackground(Color.init("Background"))
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(homeViewModel: HomeViewModel())
//    }
//}


struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var detailsViewModel: DetailsViewModel
    var homeViewModel: HomeViewModel
    @State  var isShowNext  = true


    class Coordinator: NSObject, UISearchBarDelegate {
        var detailsViewModel: DetailsViewModel
        var homeViewModel: HomeViewModel
        @Binding var text: String

        init(text: Binding<String>, detailsViewModel: DetailsViewModel, homeViewModel: HomeViewModel) {
            _text = text
            self.detailsViewModel = detailsViewModel
            self.homeViewModel = homeViewModel
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

            self.detailsViewModel.getPokemonsSearch(search: text)
            UIApplication.shared.endEditing()

            PokemonService.getPokemonSearchy(search: text ) { results, error  in
                if results != nil {
                    self.homeViewModel.pokemonListAux = self.homeViewModel.pokemonList
                    self.homeViewModel.pokemonList = []
                    guard let name = results?.name, let id = results?.id else {
                        return
                    }
                    self.homeViewModel.pokemonList.append(Pokemon(name: name, url: "https://pokeapi.co/api/v2/pokemon/\(id)/"))
                } else{
                    print("[DEBUG] no results")
                }
            }
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, detailsViewModel: detailsViewModel, homeViewModel: homeViewModel)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .none
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text

    }
}

extension String {
    func containsCaseInsensitive(_ string: String) -> Bool {
        return self.localizedCaseInsensitiveContains(string)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
