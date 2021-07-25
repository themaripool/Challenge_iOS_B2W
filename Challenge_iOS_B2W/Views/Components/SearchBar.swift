//
//  SearchBar.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 25/07/21.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var detailsViewModel: DetailsViewModel
    var homeViewModel: HomeViewModel
    @Binding var showingAlert: Bool

    class Coordinator: NSObject, UISearchBarDelegate {
        var detailsViewModel: DetailsViewModel
        var homeViewModel: HomeViewModel
        @Binding var text: String
        @Binding var showingAlert: Bool

        init(text: Binding<String>, detailsViewModel: DetailsViewModel, homeViewModel: HomeViewModel, showingAlert: Binding<Bool>) {
            _text = text
            self.detailsViewModel = detailsViewModel
            self.homeViewModel = homeViewModel
            _showingAlert = showingAlert
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            if searchText == "" {
                if self.homeViewModel.pokemonListAux != []{
                    self.homeViewModel.reloadData()
                }
            }
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

            self.detailsViewModel.getPokemonsSearch(search: text)
            UIApplication.shared.endEditing()

            PokemonService.getPokemonSearchy(search: text ) { results, error  in
                if results != nil {
                    self.homeViewModel.pokemonListAux = self.homeViewModel.pokemonList
                    self.homeViewModel.pokemonList = []
                    guard let name = results?.name, let id = results?.id else {return}
                    self.homeViewModel.pokemonList.append(Pokemon(name: name, url: "https://pokeapi.co/api/v2/pokemon/\(id)/"))
                } else{
                    UIApplication.shared.endEditing()
                    self.showingAlert.toggle()
                }
            }
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, detailsViewModel: detailsViewModel, homeViewModel: homeViewModel, showingAlert: $showingAlert)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .none
        UIApplication.shared.endEditing()
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
