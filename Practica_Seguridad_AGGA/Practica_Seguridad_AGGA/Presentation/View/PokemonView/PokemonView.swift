//
//  PokemonView.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 13/5/24.
//

import SwiftUI

struct PokemonView: View {
    
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(rootViewModel.pokemon) { pokemon in
                    PokemonRow(pokemonImageUrl: (pokemon.sprites?.front_default)!, pokemonName: pokemon.name!)
                }
            }
        }
        .padding()
        .onAppear {
            rootViewModel.loadPokemonsAPI()
        }
    }
}

#Preview {
    PokemonView().environmentObject(RootViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
}
