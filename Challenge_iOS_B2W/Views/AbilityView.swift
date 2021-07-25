//
//  AbilityView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 25/07/21.
//

import SwiftUI

struct AbilityView: View {
    @EnvironmentObject var detailsViewModel: DetailsViewModel
    var body: some View {
        if detailsViewModel.pokemonAbilityDetails.effect_entries.first?.effect == nil {
            ProgressView()
        } else {
            let text = detailsViewModel.pokemonAbilityDetails.effect_entries.first?.language.name == "en" ? detailsViewModel.pokemonAbilityDetails.effect_entries.first!.effect : detailsViewModel.pokemonAbilityDetails.effect_entries[1].effect
            
            Text(text)
                .font(.custom("Arial", size: 20))
                .padding(.all, 8)
        }
    }
}

struct AbilityView_Previews: PreviewProvider {
    static var previews: some View {
        AbilityView().environmentObject(DetailsViewModel())
    }
}
