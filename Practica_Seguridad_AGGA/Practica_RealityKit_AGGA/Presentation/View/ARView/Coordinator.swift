//
//  Coordinator.swift
//  Practica_RealityKit_AGGA
//
//  Created by Alejandro Alberto Gavira García on 9/6/24.
//

import Foundation
import RealityKit
import ARKit
import Combine

@MainActor
final class Coordinator: NSObject {
    var viewModel: PokemonViewModel
    var pokemonName: String
    var cancellables = Set<AnyCancellable>()
    var force = 1.5
    
    init(viewModel: PokemonViewModel,pokemonName: String) {
        self.viewModel = viewModel
        self.pokemonName = pokemonName.lowercased()
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let arView = recognizer.view as? ARView else { return }
        let location = recognizer.location(in: arView)
        
        guard let result = arView.raycast(from: location, allowing: .existingPlaneInfinite, alignment: .any).first else {
            NSLog("Error in the raycast")
            return
        }
        let transformAim = Transform(matrix: result.worldTransform)
        let positionAim = transformAim.translation
            
        if let pokemon = arView.entity(at: location) as? ModelEntity, pokemon.name == viewModel.selectedPokemon {
            pokemon.scale = SIMD3<Float>(0, 0, 0)
            if let pokeball = arView.scene.findEntity(named: "Ultraball") as? ModelEntity {
                pokeball.scale *= 1.5
            }
        } else {
            guard let pokeball = arView.scene.findEntity(named: "Ultraball") as? ModelEntity else {
                NSLog("The Ultraball cannot be found")
                return
            }
            pokeball.position = [0, 0, -0.5]
            pokeball.physicsBody = PhysicsBodyComponent(mode: .dynamic)
            pokeball.generateCollisionShapes(recursive: true)
            pokeball.collision = CollisionComponent(shapes: [.generateSphere(radius: 1.0)], mode: .trigger, filter: .default)
            
            arView.scene.addAnchor(AnchorEntity(world: .zero))
            arView.scene.anchors.first?.addChild(pokeball)
            
            let pushPokeball = SIMD3<Float>(0, 0.5, -1)
            pokeball.addForce(pushPokeball, at: positionAim, relativeTo: nil)

            guard let pokemon = arView.entity(at: location) as? ModelEntity, pokemon.name == viewModel.selectedPokemon else {
                NSLog("The Ultraball cannot be found")
                return
            }
            pokemon.collision = CollisionComponent(shapes: [.generateBox(size: .one)], mode: .trigger, filter: .default)
            pokemon.generateCollisionShapes(recursive: true)
            
            arView.scene.subscribe(to: CollisionEvents.Began.self) { event in
                if event.entityA.name == "Ultraball" && event.entityB.name == "\(self.viewModel.selectedPokemon)" {
                    // Si la Pokeball choca con el Pokémon
                    event.entityB.scale = SIMD3<Float>(0, 0, 0)
                    event.entityA.scale *= 1.5
                }
            }
            .store(in: &cancellables)
        }
    }
}
