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
        if pokemonViewModel.status == .loading {
            ProgressView()
        }else{
            ScrollView(.vertical){
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(pokemonViewModel.pokemons) { pokemon in
                        PokemonRow(pokemonImageUrl: (pokemon.sprites?.front_default)!, pokemonName: pokemon.name!)
                    }
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    PokemonView().environmentObject(PokemonViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
}
