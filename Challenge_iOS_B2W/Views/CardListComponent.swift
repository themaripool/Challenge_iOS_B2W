//
//  CardListComponent.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 13/07/21.
//

import SwiftUI

struct CardListComponent: View {
    
    var pokedexNumber: String
    var pokemonName: String
    var typeString: [String]
    
    
    var body: some View {
        
        ZStack {
            switch typeString.first {
                case "Grass":
                    Color("Grass")
                        .ignoresSafeArea()
                        .grayscale(0.50)
                case "Water":
                    Color("Water")
                        .ignoresSafeArea()
                        .grayscale(0.50)
                default:
                    Color("Fire")
                        .ignoresSafeArea()
                        .grayscale(0.50)
            }
            
            HStack(alignment: .center, spacing: 16){
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(pokedexNumber)
                        .bold()
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding(.top, 8.0)
                    
                    Text(pokemonName)
                        .font(.caption2)
                        .foregroundColor(Color.white)
                    
                    HStack {
                        ForEach(typeString, id: \.self) { type in
                            Text(type)
                                .font(.caption2)
                                .padding(8)
                                .background(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                            
                        }
                        
                    }.padding(.bottom, 8.0)

                }
                
                Spacer()
                
                
                Image(pokemonName)
                    .resizable()
                    .frame(width: 100, height: 80)
                
            }
            .listRowBackground(Color.clear)
            .padding(.horizontal, 8.0)
        }.cornerRadius(15)
    }
}

struct CardListComponent_Previews: PreviewProvider {
    static var previews: some View {
        CardListComponent(pokedexNumber: "#0001", pokemonName: "Bulbassauro", typeString: ["Poison", "Grass"]).frame(width: 370, height: 100)
    }
}
