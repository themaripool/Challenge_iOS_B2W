//
//  CarouselView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 25/07/21.
//

import SwiftUI
import Kingfisher

struct CarouselView: View {
    var pokedexNumber = ""
    var body: some View {
        GeometryReader { geometry in
            let num = Int(pokedexNumber)
            ImageCarouselView(numberOfImages: num! >= 888 ? 2 : 3) {
                if (num! < 888){
                    KFImage(URL(string: "https://pokeres.bastionbot.org/images/pokemon/\(pokedexNumber).png")!)
                        .resizable()
                        .frame(width: 170, height: 140)
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                    Spacer()
                }
                KFImage(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokedexNumber).png")!)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Spacer()
                KFImage(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(pokedexNumber).png")!)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Spacer()
            }
        }.frame(width: 170, height: 140, alignment: .center)
    }
}
