//
//  DetailsView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import SwiftUI
import Kingfisher

struct DetailsView: View {
    
    @EnvironmentObject var detailsViewModel: DetailsViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var showingAbilityView = false
    @State private var showingTypesView = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var selectedPokemon = "select variety"
    
    var body: some View {
        ZStack(alignment: .top, content: {
            
            if (detailsViewModel.pokemonEvolutionChain.chain.species.name == ""){
                LoadingView()
            }else{
                ScrollView {
                    PokemonHeader
                    VStack {
                        if(detailsViewModel.pokemonSpecies.varieties.count > 1){
                            pickerView
                        }
                        PokemonStats
                        PokemonAbilities
                        PokemonEvolutions
                    }
                }.edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
            }
        }).transition(.opacity.animation(.easeIn(duration: 5)))
    }
    
    var barBackButton: some View {
        Button(action: {}) {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.homeViewModel.reloadData() 
                    self.detailsViewModel.refresh()
                    self.presentationMode.wrappedValue.dismiss()
                }
        }
        .frame(width: 32, height: 32)
    }
    
    var PokemonHeader: some View {
            
        return Group {
            
            ZStack{
                let colorPKM = detailsViewModel.getColor()
                colorPKM.edgesIgnoringSafeArea(.all)

                VStack {
                    
                    HStack(alignment: .center, spacing: 8){
                        
                        barBackButton
                        
                        Spacer()
                        
                        Text(detailsViewModel.pokemonDetailsList.name.capitalized)
                            .font(.custom("Arial", size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.trailing, 8)
                        
                        Spacer()
                        
                        Text("")
                        
                    }.padding(.horizontal, 8)
                    
                    HStack(alignment: .center) {
                        
                        
                        ForEach(self.detailsViewModel.pokemonDetailsList.types.indices, id: \.self){ type in
                            
                            
                            if (self.detailsViewModel.pokemonDetailsList.types.count != 0){
                                
                                let pkmType = self.detailsViewModel.pokemonDetailsList.types[type].type.name
                                Button(action: {
                                    if(showingTypesView == false){
                                        self.detailsViewModel.getSameTypePokemons(id: detailsViewModel.pokemonTypesId[type])
                                    }
                                    showingTypesView.toggle()
                                }){
                                    Text(pkmType)
                                        .font(.custom("Arial", size: 16))
                                        .foregroundColor(.white)
                                        .padding(12)
                                        .background(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)).opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                }
                                .sheet(isPresented: $showingTypesView,
                                       onDismiss: {},
                                       content: {
                                        SameTypeView()
                                            .environmentObject(detailsViewModel)
                                       }
                                )
                            }
                        }.padding(.top, 8)
                        
                        Spacer()
                        
                        Text("#" + detailsViewModel.pokedexNumber)
                            .font(.custom("Arial", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                    }
                    
                    CarouselView(pokedexNumber: detailsViewModel.pokedexNumber)
                }
                .padding(.top, 24.0)
                .padding(.horizontal, 8.0)
                
                
            }.frame(width: UIScreen.main.bounds.width, height: 300)
        }
    }
    
    var pickerView: some View {
        
        VStack(alignment: .leading) {
            HStack(){
                Text("Pokemon Variety")
                    .font(.custom("Arial", size: 20))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 8.0)
                Spacer()
                Picker(selection: $selectedPokemon, label:
                        HStack{
                            Text(selectedPokemon)
                                .font(.headline)
                                .padding()
                                .padding(.horizontal)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10)
                                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
                        }, content: {
                            ForEach(detailsViewModel.pokemonVarietieNameList, id: \.self) {
                                Text($0)
                            }
                        })
                    .pickerStyle(MenuPickerStyle())
                Spacer()
                    //.pickerStyle(WheelPickerStyle())
                if (selectedPokemon != detailsViewModel.pokemonDetailsList.name) {
                    let index = detailsViewModel.findIndexInArray(name: selectedPokemon)
                    if (index != -1){
                        let id = detailsViewModel.idsVarieties[index]
                        var _ = self.detailsViewModel.refresh()
                        var _ = self.detailsViewModel.getPokemonsDetails(index: id)
                        var _ = self.detailsViewModel.setVariables(number: "\(id)")
                    }
                }
            }
        }
        .padding(.horizontal, 8.0)
    }
    
    var PokemonStats: some View {
                
        return Group {
            
            HStack(alignment:.center){

                VStack(alignment: .leading){
                    ForEach (self.detailsViewModel.pokemonDetailsList.stats.indices, id: \.self){ index in
                        let stats = self.detailsViewModel.pokemonDetailsList.stats[index]
                            Text(stats.stat.name)
                    }
                }
                
                VStack(alignment: .center){
                    ForEach (self.detailsViewModel.pokemonDetailsList.stats.indices, id: \.self){ index in
                        let stats = self.detailsViewModel.pokemonDetailsList.stats[index]
                        Text("\(stats.base_stat)")
                    }
                }
                
                VStack(alignment: .trailing){
                    ForEach (self.detailsViewModel.pokemonDetailsList.stats.indices, id: \.self){ index in
                        let stats = self.detailsViewModel.pokemonDetailsList.stats[index]
                        ProgressBar(value: Float(stats.base_stat)).frame(height: 12).environmentObject(detailsViewModel)
                    }
                }
            }
            .padding(.horizontal, 8.0)
            .padding(.top, 16)
        }
        
    }
    
    var PokemonAbilities: some View {
        
        return Group {
            
            let colorPKM = detailsViewModel.getColor()
            
            VStack(alignment: .leading) {
                HStack(){
                    Text("Abilities")
                        .font(.custom("Arial", size: 26))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 8.0)
                    Spacer()
                }
                VStack(alignment: .leading){
                    
                    ForEach (self.detailsViewModel.pokemonDetailsList.abilities.indices, id: \.self){ index in
                        let abilities = self.detailsViewModel.pokemonDetailsList.abilities[index]
                       
                        var id = "0"
                        Button(action: {
                            id = self.detailsViewModel.extractAbilityId(urlAbility: abilities.ability.url)
                            detailsViewModel.getAbilityDetails(index: Int(id)! )
                            showingAbilityView.toggle()
                        }){
                            Text(abilities.ability.name.capitalized).font(.custom("Arial", size: 21))
                                .foregroundColor(colorPKM)
                                .fontWeight(.semibold)
                        }
                        .sheet(isPresented: $showingAbilityView,
                               onDismiss: {self.detailsViewModel.refreshAbilities()},
                               content: {
                                AbilityView()
                                    .environmentObject(detailsViewModel)
                                    .onAppear(){
                                    }
                               }
                        )
                        .padding(.bottom, 8.0)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 8.0)
        }
    }
    
    var PokemonEvolutions: some View {
        
        //https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png
        
        return Group {
            
            VStack(alignment: .leading) {
                HStack(){
                    Text("Evolutions")
                        .font(.custom("Arial", size: 26))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                if detailsViewModel.ids.count != 0 && detailsViewModel.ids.count > 1 {
                    ScrollView(.horizontal, showsIndicators: true){
                        HStack{
                            ForEach (detailsViewModel.ids.indices) { indice in
                                VStack(alignment: .center){
                                    let id = detailsViewModel.ids[indice]
                                    let name = detailsViewModel.names[indice]
                                    KFImage(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!)
                                        .placeholder {
                                            Image(uiImage: UIImage(named: "placeholder")!)
                                                .resizable()
                                                .renderingMode(.original)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 50, height: 40)
                                        }
                                        .resizable()
                                        .padding(.top, 8.0)
                                        .frame(width: 110, height: 110)
                                    
                                    Text(name).font(.custom("Arial", size: 16))
                                }
                            }
                        }
                        .padding(.bottom, 16)
                    }
                    
                }
                else{
                    Text("No Evolution")
                }
            }
            .padding(.horizontal, 8.0)
        }
        
    }
}
