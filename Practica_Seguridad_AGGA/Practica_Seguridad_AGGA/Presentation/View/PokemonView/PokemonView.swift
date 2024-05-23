//
//  PokemonView.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 13/5/24.
//

import SwiftUI

struct PokemonView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var pokemons: [Pokemon] = []
    
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(pokemons) { pokemon in
                    PokemonRow(pokemonImageUrl: (pokemon.sprites?.front_default)!, pokemonName: pokemon.name!)
                }
            }
        }
        .padding()
        .onAppear {
            DispatchQueue.main.async {
                self.pokemons = homeViewModel.pokemon
            }
        }
    }
}

#Preview {
    PokemonView().environmentObject(HomeViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
}
