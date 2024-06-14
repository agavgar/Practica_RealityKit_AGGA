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
    var pokemonName: String
    
    init(pokemonName: String) {
        self.pokemonName = pokemonName
    }
    
    var body: some View {
        ARViewContainer(viewModel: self.viewModel, pokemonName: self.pokemonName)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    var viewModel: PokemonViewModel
    var pokemonName: String
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
                config.planeDetection = [.horizontal]
                arView.session.run(config)
        
        let scene = try! PokemonScenePrueba.loadPokemonScene()
        let anchor = AnchorEntity(world: .zero)
        
        guard let stadium = scene.findEntity(named: "Training") else {
            NSLog("Couldn't find the stadium")
            return arView
        }
        stadium.position = .zero
        anchor.addChild(stadium)
        
        guard let pokemon = scene.findEntity(named: "\(pokemonName)") else {
            NSLog("Couldn't find the pokemon")
            return arView
        }
        pokemon.position = SIMD3<Float>(x: 0.0, y: 0.01, z: -2.0)
        pokemon.scale *= 0.5
        anchor.addChild(pokemon)
        
        guard let pokeball = scene.findEntity(named: "Ultraball") else {
            NSLog("Couldn't find the ultraball")
            return arView
        }
        pokeball.position = SIMD3<Float>(x: -10.0, y: 0.0, z: -1.0)
        anchor.addChild(pokeball)
               
        arView.scene.anchors.append(anchor)
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap))
        arView.addGestureRecognizer(tapGesture)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: self.viewModel, pokemonName: self.pokemonName)
    }
}
#Preview {
    ContentView(pokemonName: "charmander")
}
