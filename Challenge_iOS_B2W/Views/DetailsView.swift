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
    //var pokedexNumber = ""
    @State var selectedPokemon = " "
    
    var body: some View {
        ZStack(alignment: .top, content: {
            
            if (detailsViewModel.pokemonChain.chain.species.name == ""){
                HomeLoadingView()
            }else{
                ScrollView {
                    PokemonHeader
                    VStack {
                        if(detailsViewModel.pokemonEvChain.varieties.count > 1){
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
                    self.homeViewModel.reloadData() //-> ver bug do carregamento eterno
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
                    
                    HStack(alignment: .center){
                        
                        barBackButton
                        
                        Spacer()
                        
                        Text(detailsViewModel.pokemonDetailsList.name.capitalized)
                            .font(.custom("Arial", size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    
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
                        }
                        
                        Spacer()
                        
                        Text("#" + detailsViewModel.pokedexNumber)
                            .font(.custom("Arial", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                    }
                    
                    CarouselView(pokedexNumber: detailsViewModel.pokedexNumber)
                }
                .padding(.top, 64.0)
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
                        var _ = self.detailsViewModel.setVariables(number: "\(id)", selected: selectedPokemon)
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
    
    //TODO: Se pokemon n evoluir, colocar um aviso
    var PokemonEvolutions: some View {
        
        //https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png
        
        return Group {
            
            VStack(alignment: .leading) {
                HStack(){
                    Text("Evolutions")
                        .font(.custom("Arial", size: 26))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 8.0)
                    Spacer()
                }
                
                if detailsViewModel.ids.count > 3{
                    
                    VStack{
                        ForEach (detailsViewModel.ids.indices) { indice in
                            HStack(){
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
                                    .frame(width: 90, height: 90)
                                
                                Text(name).font(.custom("Arial", size: 16))
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    
                    
                } else if detailsViewModel.ids.count != 0 && detailsViewModel.ids.count > 1 {
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
                                    .frame(width: 90, height: 90)
                                
                                Text(name).font(.custom("Arial", size: 16))
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                }
                else{
                    Text("No Evolution")
                }
            }
            .padding(.horizontal, 8.0)
        }
        
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView().environmentObject(DetailsViewModel())
    }
}

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

struct AbilityId_Previews: PreviewProvider {
    static var previews: some View {
        AbilityView().environmentObject(DetailsViewModel())
    }
}

//MARK: View da
struct ProgressBar: View {
    @EnvironmentObject var detailsViewModel: DetailsViewModel
    
    var value: Float
    
    
    var body: some View {
        let colorPKM = detailsViewModel.getColor()
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(colorPKM.opacity(0.4))
                
                Rectangle().frame(width: min((CGFloat(self.value) * geometry.size.width) / 255, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(colorPKM)
            }.cornerRadius(45.0)
        }
    }
}
