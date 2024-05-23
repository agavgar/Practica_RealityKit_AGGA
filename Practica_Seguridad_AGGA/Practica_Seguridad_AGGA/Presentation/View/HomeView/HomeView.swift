//
//  ContentView.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 10/5/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel

    var body: some View {
        switch (homeViewModel.status) {
        case Status.loading:
            ProgressView("Loading Pokedex and Backpack")
                .foregroundStyle(.yellow)
                .bold()
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
    HomeView()
        .environmentObject(HomeViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
}
