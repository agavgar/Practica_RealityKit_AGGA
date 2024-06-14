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
    var force: Float = 10
    
    init(viewModel: PokemonViewModel,pokemonName: String) {
        self.viewModel = viewModel
        self.pokemonName = pokemonName.lowercased()
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let arView = recognizer.view as? ARView else { return }
        let location = recognizer.location(in: arView)
        
        print(pokemonName)
        
        guard let pokemon = arView.scene.findEntity(named: "\(pokemonName)") else {
            NSLog("The pokemon cannot be found")
            return
        }
        pokemon.components[CollisionComponent.self] = CollisionComponent(shapes: [.generateBox(size: .one)], mode: .trigger, filter: .default)
        
        guard let pokeball = arView.scene.findEntity(named: "Ultraball") else {
            NSLog("The Ultraball cannot be found")
            return
        }
        pokeball.position = [0, 0.0 , -1]
        // Rigidbody contains Physics
        pokeball.components[PhysicsBodyComponent.self] = PhysicsBodyComponent(mode: .dynamic)
        // Collision to detect the collision
        let collisionShape = ShapeResource.generateSphere(radius: 1.0)
        pokeball.components[CollisionComponent.self] = CollisionComponent(shapes: [collisionShape], mode: .trigger, filter: .default)
        //Throw
        let movementAxis = SIMD3<Float>(0, 0, -1 * force)
        //Reset the physics
        pokeball.components[PhysicsMotionComponent.self] = PhysicsMotionComponent(linearVelocity: .zero, angularVelocity: .zero)
        // Add the throw
        pokeball.components[PhysicsMotionComponent.self] = PhysicsMotionComponent(linearVelocity: movementAxis, angularVelocity: .zero)
        
        arView.scene.subscribe(to: CollisionEvents.Began.self) { event in
            if event.entityA.name == "Ultraball" && event.entityB.name == "\(self.pokemonName)" {
                // Si la Pokeball choca con el Pokémon
                event.entityB.scale = SIMD3<Float>(0, 0, 0)
                event.entityA.scale *= 1.5
            }
            
            DispatchQueue.main.async {
                
            }
        }
        .store(in: &cancellables)
    }
}
