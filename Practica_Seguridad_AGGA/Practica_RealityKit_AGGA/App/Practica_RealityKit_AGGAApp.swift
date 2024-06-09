//
//  Practica_Seguridad_AGGAApp.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 10/5/24.
//

import SwiftUI

@main
struct Practica_RealityKit_AGGAApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonView().environmentObject(PokemonViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
        }
    }
}
