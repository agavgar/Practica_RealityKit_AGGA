//
//  PokemonAR.swift
//  Practica_RealityKit_AGGA
//
//  Created by Alejandro Alberto Gavira García on 8/6/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    @EnvironmentObject private var viewModel: PokemonViewModel
    
    var body: some View {
        ARViewContainer(viewModel: self.viewModel)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    var viewModel: PokemonViewModel
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        guard let scene = try? PokemonScene.load_PokemonScene() else {
            NSLog("Scene not found")
        }
        arView.scene.anchors.append(scene)
        
        guard let stadium = scene.findEntity(named: "Training") else {
            NSLog("Couldn't find the stadium")
        }
        stadium.position = .zero
        scene.addChild(stadium)
        
        guard let pokemon = scene.findEntity(named: "\(viewModel.selectedPokemon)") else {
            NSLog("Couldn't find the pokemon")
        }
        pokemon.position = .zero
        pokemon.position.y += 0.05
        scene.addChild(pokemon)
               
            
        // Agregar gesto de toque
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap))
        arView.addGestureRecognizer(tapGesture)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: self.viewModel)
    }
}
#Preview {
    ContentView()
}
