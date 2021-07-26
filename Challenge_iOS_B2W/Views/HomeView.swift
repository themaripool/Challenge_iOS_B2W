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
import PartialSheet

struct HomeView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var detailsViewModel: DetailsViewModel
    @State private var searchText: String = ""
    @State var showingAlert: Bool = false
    
    var pkm = [Pokemon(name: "a", url: "")]
    
    var body: some View {
        NavigationView {
            if homeViewModel.pokemonList.count == 0{
                LoadingView()
            } else {
                List() {
                    SearchBar(text: $searchText, detailsViewModel: detailsViewModel, homeViewModel: homeViewModel, showingAlert: self.$showingAlert)
                        .alert(isPresented: $showingAlert) { () -> Alert in
                            return Alert(title: Text("Oops!"), message: Text("No pokemon found with this id or name"), dismissButton: .default(Text("Got it!")))
                        }
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
                                                .setVariables(number: id)
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
                }
                .onAppear(){searchText = ""}
                .navigationBarTitle("Pokedex")
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}
