//
//  DetailsView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import SwiftUI
import Kingfisher

struct DetailsView: View {
    
    @State private var showingSheet = false
    @State private var showingMove = false
    @ObservedObject var detailsViewModel: DetailsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var pokedexNumber: String
    
    init(_ pokedexNumber: String, _ detailsViewModel: DetailsViewModel) {
        
        self.pokedexNumber = pokedexNumber
        self.detailsViewModel = detailsViewModel
        
        detailsViewModel.getPokemonsDetails(index: Int(pokedexNumber)!)

    }
    
    var body: some View {
        ZStack(alignment: .top, content: {
            
            ScrollView {
                PokemonHeader
                VStack {
                    PokemonStats
                    PokemonAbilities
                    PokemonEvolutions
                    PokemonMoves
                }
            }.edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: self.barBackButton)
        })
    }
    
    var barBackButton: some View {
        Button(action: {}) {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
        }
        .frame(width: 32, height: 32)
    }
    
    var PokemonHeader: some View {
        
//        var type = self.detailsViewModel.pokemonDetailsList.types.first?.type.name
        
        return Group {
            
            ZStack{
                let colorPKM = detailsViewModel.getColor()
                colorPKM.edgesIgnoringSafeArea(.all)

                VStack {
                    
                    Text("Charmander")
                        .font(.custom("Arial", size: 32))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack(alignment: .center) {
                        
                        Text((self.detailsViewModel.pokemonDetailsList.types.first?.type.name)!)
                            .font(.custom("Arial", size: 16))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                        
                        Spacer()
                        
                        Text("#" + pokedexNumber)
                            .font(.custom("Arial", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                    }
                    
                    KFImage(URL(string: "https://pokeres.bastionbot.org/images/pokemon/\(pokedexNumber).png")!)
                        .placeholder {
                            Image(uiImage: UIImage(named: "placeholder")!)
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 80)
                        }
                        .resizable()
                        .padding(.top, 8.0)
                        .padding(.bottom, 8.0)
                        .frame(width: 170, height: 140)
                    
                    
                }
                .padding(.top, 64.0)
                .padding(.horizontal, 8.0)
                
                
            }.frame(width: UIScreen.main.bounds.width, height: 300)
        }
    }
    
    var PokemonStats: some View {
                
        return Group {
            
            HStack{
                VStack(alignment: .leading){
                    Text("HP")
                    Text("Attack")
                    Text("Defense")
                    Text("Sp Attack")
                    Text("Sp Defense")
                    Text("Speed")
                }
                VStack(alignment: .center){
                    Text("45")
                    Text("60")
                    Text("45")
                    Text("45")
                    Text("45")
                    Text("45")
                }
                VStack(alignment: .trailing){
                    ProgressBar(value: 45.0).frame(height: 12).environmentObject(detailsViewModel)
                    ProgressBar(value: 60.0).frame(height: 12).environmentObject(detailsViewModel)
                    ProgressBar(value: 45.0).frame(height: 12).environmentObject(detailsViewModel)
                    ProgressBar(value: 45.0).frame(height: 12).environmentObject(detailsViewModel)
                    ProgressBar(value: 45.0).frame(height: 12).environmentObject(detailsViewModel)
                    ProgressBar(value: 45.0).frame(height: 12).environmentObject(detailsViewModel)
                }
            }
            .padding(.horizontal, 8.0)
            .padding(.top, 16)
        }
        
    }
    
    var PokemonAbilities: some View {
        
        return Group {
            
            VStack(alignment: .leading) {
                Text("Abilities")
                    .font(.custom("Arial", size: 28))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 8.0)
                HStack(){
                    Button(action: {
                        showingSheet.toggle()
                    }){
                        Text("Blaze").font(.custom("Arial", size: 26))
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $showingSheet,
                           onDismiss: {
                            print("teste")
                           },
                           content: {
                            SheetView()
                           }
                    )
                    Spacer()
                    Text("Solar Power").font(.custom("Arial", size: 26))
                }
                .padding()
            }
            .padding(.horizontal, 8.0)
            
            
        }
        
    }
    
    var PokemonEvolutions: some View {
        
        //https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png
        
        return Group {
            
            VStack(alignment: .leading) {
                Text("Evolutions")
                    .font(.custom("Arial", size: 28))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                HStack{
                    VStack(alignment: .center){
                        
                        KFImage(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png")!)
                            .placeholder {
                                Image(uiImage: UIImage(named: "placeholder")!)
                                    .resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 40)
                            }
                            .resizable()
                            .padding(.top, 8.0)
                            .frame(width: 100, height: 90)
                        
                        Text("Charmeleon").font(.custom("Arial", size: 16))
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center){
                        
                        KFImage(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png")!)
                            .placeholder {
                                Image(uiImage: UIImage(named: "placeholder")!)
                                    .resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 40)
                            }
                            .resizable()
                            .padding(.top, 8.0)
                            .frame(width: 100, height: 90)
                        
                        Text("Charizard").font(.custom("Arial", size: 16))
                        
                    }
                }
                .padding()
            }
            .padding(.horizontal, 8.0)
            
            
        }
        
    }
    
    var PokemonMoves: some View{
        return Group{
            
            VStack(alignment: .leading) {
                Text("Moves")
                    .font(.custom("Arial", size: 28))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 8.0)
                
                HStack{
                    Button(action: {
                        showingMove.toggle()
                    }){
                        Text("Mega Punch").font(.custom("Arial", size: 26))
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $showingMove,
                           onDismiss: {
                            print("teste")
                           },
                           content: {
                            MoveView()
                           }
                    )
                    
                    Spacer()
                    
                    Image("normal")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                    
                }
                
                
            }
            
        }
    }
    
    
    
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView("0", DetailsViewModel()).environmentObject(DetailsViewModel())
    }
}

struct SheetView: View {
    
    var body: some View {
        Text("Tela de sheet")
            .font(.title)
            .padding()
    }
}

struct MoveView: View {
    
    var body: some View {
        VStack{
            
            VStack(alignment: .leading){
                Text("Mega Punch")
                    .font(.custom("Arial", size: 28))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 8.0)
                
                HStack{
                    Text("Inflicts regular damage.  For the next 2–5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.  The user continues to use other moves during this time.  If the user leaves the field, this effect ends.\n\nHas a 3/8 chance each to hit 2 or 3 times, and a 1/8 chance each to hit 4 or 5 times.  Averages to 3 hits per use.\n\nrapid spin cancels this effect.")
                }
                
            }
            
            VStack(alignment: .leading){
                Text("Stats")
                    .font(.custom("Arial", size: 28))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 8.0)
                HStack{
                    VStack{
                        Text("PWR").font(.custom("Arial", size: 24))
                        Text("80").font(.custom("Arial", size: 24)).fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack{
                        Text("ACC").font(.custom("Arial", size: 24))
                        Text("85").font(.custom("Arial", size: 24)).fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack{
                        Text("PP").font(.custom("Arial", size: 24))
                        Text("20").font(.custom("Arial", size: 24)).fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack{
                        Text("PRIO").font(.custom("Arial", size: 24))
                        Text("0").font(.custom("Arial", size: 24)).fontWeight(.bold)
                    }
                }
            }
            .padding(.horizontal, 8.0)
        }.frame(width: UIScreen.main.bounds.width, height: 500)
    }
}

struct MoveView_Previews: PreviewProvider {
    static var previews: some View {
        MoveView()
    }
}

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
                
                Rectangle().frame(width: min((CGFloat(self.value) * geometry.size.width) / 100, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(colorPKM)
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}



//            Text("a")
//
//            ForEach(self.detailsViewModel.pokemonDetailsList.types.indices, id: \.self) { index in
//                var ab = self.detailsViewModel.pokemonDetailsList.types[index]
//                Text(ab.type.name)
//                Text("\(ab.slot)")
//            }
//
//            ForEach(self.detailsViewModel.pokemonDetailsList.abilities.indices, id: \.self) { index in
//                var ab = self.detailsViewModel.pokemonDetailsList.abilities[index]
//                Text(ab.ability.name)
//                Text("\(ab.is_hidden.description)")
//                Text("\(ab.slot)")
//            }
//            Text(detailsViewModel.pokemonDetailsList.id)
//            Text(detailsViewModel.pokemonDetailsList.types)



//                switch type {
//                case "bug":
//                    Color("Bug")
//                        .ignoresSafeArea()
//                case "dark":
//                    Color("Dark")
//                        .ignoresSafeArea()
//                case "dragon":
//                    Color("Dragon")
//                        .ignoresSafeArea()
//                case "eletric":
//                    Color("Eletric")
//                        .ignoresSafeArea()
//                case "fairy":
//                    Color("Fairy")
//                        .ignoresSafeArea()
//                case "fighting":
//                    Color("Fighting")
//                        .ignoresSafeArea()
//                case "fire":
//                    Color("Fire")
//                        .ignoresSafeArea()
//                case "flying":
//                    Color("Flying")
//                        .ignoresSafeArea()
//                case "ghost":
//                    Color("Ghost")
//                        .ignoresSafeArea()
//                case "grass":
//                    Color("Grass")
//                        .ignoresSafeArea()
//                case "ground":
//                    Color("Ground")
//                        .ignoresSafeArea()
//                case "ice":
//                    Color("Ice")
//                        .ignoresSafeArea()
//                case "normal":
//                    Color("Normal")
//                        .ignoresSafeArea()
//                case "poison":
//                    Color("Poison")
//                        .ignoresSafeArea()
//                case "psychic":
//                    Color("Psychic")
//                        .ignoresSafeArea()
//                case "rock":
//                    Color("Rock")
//                        .ignoresSafeArea()
//                case "shadow":
//                    Color("Shadow")
//                        .ignoresSafeArea()
//                case "steel":
//                    Color("Steel")
//                        .ignoresSafeArea()
//                case "unknown":
//                    Color("Unknown")
//                        .ignoresSafeArea()
//                case "water":
//                    Color("Water")
//                        .ignoresSafeArea()
//                default:
//                    Color("Background")
//                        .ignoresSafeArea()
//                }
