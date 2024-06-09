//
//  PokemonAR.swift
//  Practica_RealityKit_AGGA
//
//  Created by Alejandro Alberto Gavira García on 8/6/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @EnvironmentObject var pokemonViewModel: PokemonViewModel
    let pokemonList = AllPokemon
    
    var body: some View {
            ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

        arView
            .addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(FornitureCoordinator.tapped(_:))))
        
        context.coordinator.arView = arView
        
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

#Preview {
    ContentView()
}
