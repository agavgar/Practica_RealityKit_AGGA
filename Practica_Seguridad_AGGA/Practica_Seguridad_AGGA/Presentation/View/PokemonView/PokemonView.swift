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
            VStack(spacing: 20){
                ForEach(rootViewModel.pokemon) { pokemon in
                    Text("\(pokemon.name!)")
                }
            }
        }
        .onAppear {
            rootViewModel.loadPokemonsAPI()
        }
    }
}

#Preview {
    PokemonView().environmentObject(RootViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
}
