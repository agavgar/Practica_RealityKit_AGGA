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
    var force: Float = 8
    
    init(viewModel: PokemonViewModel,pokemonName: String) {
        self.viewModel = viewModel
        self.pokemonName = pokemonName.lowercased()
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let arView = recognizer.view as? ARView else { return }
        let location = recognizer.location(in: arView)
        
        //print(pokemonName)
        
        //Transform the touch location of the device to a 3DSpace.
        let raycast = arView.makeRaycastQuery(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        let raycastResult = arView.session.raycast(raycast!)
        
        let initialPosition: SIMD3<Float>
        if let result = raycastResult.first {
            let hitPosition = result.worldTransform.columns.3
            initialPosition = [hitPosition.x, hitPosition.y, -1]
        } else {
            initialPosition = [0, 0.2, -1]
        }
        
        guard let pokemon = arView.scene.findEntity(named: "\(pokemonName)") else {
            NSLog("The pokemon cannot be found")
            return
        }
        pokemon.components[CollisionComponent.self] = CollisionComponent(shapes: [.generateBox(size: .one)], mode: .trigger, filter: .sensor)
        
        guard let pokeball = arView.scene.findEntity(named: "Ultraball") else {
            NSLog("The Ultraball cannot be found")
            return
        }
        pokeball.position = initialPosition
        pokeball.orientation = simd_quatf(angle: 0, axis: SIMD3<Float>(0, 0, 1))
        pokeball.scale = SIMD3<Float>(1, 1, 1)
        pokeball.generateCollisionShapes(recursive: true)
        // Rigidbody contains Physics
        pokeball.components[PhysicsBodyComponent.self] = PhysicsBodyComponent(mode: .dynamic)
        // Collision to detect the collision
        let collisionShape = ShapeResource.generateSphere(radius: 0.15)
        pokeball.components[CollisionComponent.self] = CollisionComponent(shapes: [collisionShape], mode: .trigger, filter: .sensor)
        //Throw
        let movementAxis = SIMD3<Float>(0, 0, -1 * force)
        // Add the throw
        pokeball.components[PhysicsMotionComponent.self] = PhysicsMotionComponent(linearVelocity: movementAxis, angularVelocity: .zero)
        //Reset the physics
        //pokeball.components[PhysicsMotionComponent.self] = PhysicsMotionComponent(linearVelocity: .zero, angularVelocity: .zero)

        
        arView.scene.subscribe(to: CollisionEvents.Began.self) { event in
            if event.entityA.name == "Ultraball" && event.entityB.name == "\(self.pokemonName)" {
                // Si la Pokeball choca con el Pokémon
                
                
//                let identityRotation = simd_quatf(angle: 90, axis: SIMD3<Float>(0.5, 1, 0))
//                let scaleDown = Transform(scale: SIMD3<Float>(0, 0, 0), rotation: identityRotation, translation: event.entityB.transform.translation)
//                event.entityB.move(to: scaleDown, relativeTo: event.entityB, duration: 20)
//                
//                let scaleUp = Transform(scale: SIMD3<Float>(1.5, 1.5, 1.5), rotation: identityRotation, translation: event.entityA.transform.translation)
//                event.entityA.move(to: scaleUp, relativeTo: event.entityA, duration: 20)
                
                event.entityB.scale = SIMD3<Float>(0, 0, 0)
                event.entityA.scale *= 1.5
                
                self.viewModel.pokemonCaptured()
            }
            
            DispatchQueue.main.async {
                
            }
        }
        .store(in: &cancellables)
        
        
        arView.scene.subscribe(to: CollisionEvents.Ended.self) { _ in
            //self.viewModel.pokemonCaptured()
        }
        .store(in: &cancellables)
    }
}
