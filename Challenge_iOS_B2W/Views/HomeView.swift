//
//  HomeView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 13/07/21.
//

import SwiftUI
import UIKit
import Foundation
import Kingfisher

struct HomeView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var detailsViewModel: DetailsViewModel
    @State private var searchText: String = ""
    
    var pkm = [Pokemon(name: "a", url: "")]

    var body: some View {
        NavigationView {
            if homeViewModel.pokemonList.count == 0{
                
                HomeLoadingView()
                
            } else {
                List() {
                    SearchBar(text: $searchText, detailsViewModel: detailsViewModel, homeViewModel: homeViewModel)
                    ForEach(self.homeViewModel.pokemonList.indices, id: \.self) { index in
                        let pokemon = self.homeViewModel.pokemonList[index]
                        let id = self.homeViewModel.extractIdFromPokemon(urlPokemon: pokemon.url)
                        
                        NavigationLink(destination:
                                        DetailsView()
                                        .environmentObject(detailsViewModel)
                                        .environmentObject(homeViewModel)
                                        .navigationBarBackButtonHidden(true)
                                        .onAppear(){
                                            detailsViewModel
                                                .getPokemonsDetails(index: Int(id)!)
                                            detailsViewModel
                                                .setVariables(number: id, selected: detailsViewModel.pokemonVarietieNameList.first ?? "")
                                        }) {
                            HStack(alignment: .center, spacing: 16){
                                
                                Text(id)
                                    .bold()
                                    .font(.custom("Arial", size: 32))
                                    .padding(.top, 8.0)
                                
                                Text(pokemon.name.capitalized)
                                    .bold()
                                    .font(.custom("Arial", size: 20))
                                
                                Spacer()
                                
                                KFImage(URL(string: "https://pokeres.bastionbot.org/images/pokemon/\(id).png"))
                                    .placeholder {
                                        Image(uiImage: UIImage(named: "placeholder")!)
                                            .resizable()
                                            .renderingMode(.original)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 80)
                                    }
                                    .resizable()
                                    .frame(width: 100, height: 80)
                                
                            }
                            .listRowBackground(Color.clear)
                            .padding(.horizontal, 8.0)
                        }
                    }
                }.onAppear(){searchText = ""}
                
                .navigationBarTitle("Pokedex")
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}

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
                    guard let name = results?.name, let id = results?.id else {return}
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
