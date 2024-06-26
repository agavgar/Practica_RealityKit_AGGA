//
//  PokemonCell.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/5/24.
//

import SwiftUI

struct PokemonRow: View {
    var pokemonImageUrl: String
    var pokemonName: String
    @State private var pokemonImage: Image? = nil
    
    init(pokemonImageUrl: String, pokemonName: String) {
        self.pokemonImageUrl = pokemonImageUrl
        self.pokemonName = pokemonName
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 155, height: 155)
                    .id(1)
                Circle()
                    .fill(Color.red)
                    .frame(width: 150, height: 150)
                    .id(2)
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 150, height: 150)
                    .offset(y:75)
                    .clipShape(.circle)
                    .id(3)
                if let pokemonImage = pokemonImage {
                    pokemonImage
                        .resizable()
                        .clipShape(.circle)
                        .frame(width: 150, height: 150)
                        .id(4)
                }else{
                    ProgressView()
                }
            }
            Text(pokemonName)
                .font(.title2)
                .bold()
                .foregroundStyle(.red)
                .id(5)
        }
        .onAppear {
            Task(priority: .medium) {
                pokemonImage = await Image(uiImage: UIImage.loadImage(url: pokemonImageUrl)!)
            }
            
        }
    }
}


#Preview {
    PokemonRow(pokemonImageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", pokemonName: "Bulbasur")
}
