//
//  PokemonView.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 13/5/24.
//

import SwiftUI

struct PokemonView: View {
    
    @EnvironmentObject var pokemonViewModel: PokemonViewModel
    
    var body: some View {
        NavigationView {
            if pokemonViewModel.status == .loading {
                ProgressView()
            }else{
                ScrollView(.vertical){
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(pokemonViewModel.pokemons) { pokemon in
                            ForEach(pokemonViewModel.pokemons) { pokemon in
                                Button(action: {
                                    pokemonViewModel.selectedPokemon = pokemon.name!
                                    NavigationLink(""){
                                        ARViewContainer(viewModel: self.pokemonViewModel)
                                    }
                                }) {
                                    PokemonRow(pokemonImageUrl: (pokemon.sprites?.front_default)!, pokemonName: pokemon.name!)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    PokemonView().environmentObject(PokemonViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
}
