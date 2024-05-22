//
//  ContentView.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 10/5/24.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        switch (rootViewModel.status) {
        case Status.loading:
            ProgressView()
        case Status.loaded:
            TabView {
                PokemonView()
                    .tabItem {
                        Image(systemName: "book.pages")
                        Text("Pokedex")
                    }   
                ItemView()
                    .tabItem {
                        Image(systemName: "backpack")
                        Text("Backpack")
                    }
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(RootViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
}
