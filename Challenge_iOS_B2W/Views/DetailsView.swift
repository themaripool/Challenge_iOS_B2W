//
//  DetailsView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import SwiftUI

struct DetailsView: View {

    @EnvironmentObject var detailsViewModel: DetailsViewModel
    
    var body: some View {
        VStack{
            Text("a")
            
            ForEach(self.detailsViewModel.pokemonDetailsList.types.indices, id: \.self) { index in
                var ab = self.detailsViewModel.pokemonDetailsList.types[index]
                Text(ab.type.name)
                Text("\(ab.slot)")
            }
            
            ForEach(self.detailsViewModel.pokemonDetailsList.abilities.indices, id: \.self) { index in
                var ab = self.detailsViewModel.pokemonDetailsList.abilities[index]
                Text(ab.ability.name)
                Text("\(ab.is_hidden.description)")
                Text("\(ab.slot)")
            }
//            Text(detailsViewModel.pokemonDetailsList.id)
//            Text(detailsViewModel.pokemonDetailsList.types)
        }
        //Text("aaa \(detailsViewModel.pokemonDetailsList?.id)")
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}
