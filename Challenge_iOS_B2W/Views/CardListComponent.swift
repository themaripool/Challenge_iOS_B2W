//
//  CardListComponent.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 13/07/21.
//

import SwiftUI
import Kingfisher

struct CardListComponent: View {
        
    @ObservedObject var detailsViewModel: DetailsViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var pokedexNumber: String
    var pokemonName: String
    var index: Int
    
    var body: some View {
        
        ZStack {
            Color.init("Background")
            
            NavigationLink(destination:
                            DetailsView(pokedexNumber: pokedexNumber)
                            .environmentObject(detailsViewModel)
                            .environmentObject(homeViewModel)
                            .navigationBarBackButtonHidden(true)
                .onAppear(){
                    print("index clicdo eh \(index)")
                    detailsViewModel
                        .getPokemonsDetails(index: Int(pokedexNumber)!)
                        
                                
            }) { EmptyView()}.frame(width: 0)
            
            HStack(alignment: .center, spacing: 16){
                
                Text(pokedexNumber)
                    .bold()
                    .font(.custom("Arial", size: 32))
                    .padding(.top, 8.0)
                
                Text(pokemonName.capitalized)
                    .bold()
                    .font(.custom("Arial", size: 20))
                    .foregroundColor(Color.black)
                
                Spacer()
                
                KFImage(URL(string: "https://pokeres.bastionbot.org/images/pokemon/\(pokedexNumber).png")!)
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
        }.cornerRadius(15)
    }
}
