//
//  SameTypeView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 25/07/21.
//

import SwiftUI
import Kingfisher

struct SameTypeView: View {
    @EnvironmentObject var detailsViewModel: DetailsViewModel
    var body: some View {
        
        if detailsViewModel.sameTypePokemon.isEmpty {
            ProgressView()
        } else {
            List(detailsViewModel.sameTypePokemon.indices, id: \.self){ element in
                let el = detailsViewModel.sameTypePokemon[element].pokemon
                let idPokemon = detailsViewModel.extractIdFromVariety(urlPokemon: el.url)
                HStack(){
                    
                    KFImage(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(idPokemon).png")!)
                        .placeholder {
                            Image(uiImage: UIImage(named: "placeholder")!)
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 40)
                        }
                        .resizable()
                        .padding(.top, 8.0)
                        .frame(width: 90, height: 90)
                    
                    Text(el.name)
                        .font(.custom("Arial", size: 20))
                        .padding(.all, 8)
                }
            }
        }
    }
}
