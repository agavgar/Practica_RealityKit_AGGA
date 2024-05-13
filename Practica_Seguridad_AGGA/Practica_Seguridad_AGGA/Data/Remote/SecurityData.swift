//
//  SecurityData.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/5/24.
//

import Foundation
import KeychainSwift
import LocalAuthentication

final class SecurityData {
    
    //MARK: - Properties
    static let securityShare = SecurityData()
    
    //MARK: - Init
    private init() {}
    
    //MARK: - Methods
    func savePokemon(pokemon: Data) {
        if let value = String(data: pokemon, encoding: .utf8){
            KeychainSwift().set(value, forKey: "Pokemon")
        }
        print("Error KeychainSaveData -> Save -> Error saving pokemon. Pokemons stored = nothing")
        KeychainSwift().set("", forKey: "Pokemon")
    }
    
    func loadPokemon() -> [Pokemon]? {
        if let data = KeychainSwift().get("Pokemon") {
            if let jsonPokedex = data.data(using: .utf8) {
                do {
                    return try JSONDecoder().decode([Pokemon].self, from: jsonPokedex)
                }catch {
                    print("Error KeychainSaveData -> Load -> Error decoding pokemon")
                    return []
                }
            }
        }else{
            print("Error KeychainSaveData -> Load -> Error loading pokemon")
            return []
        }
        return []
    }
    
    func authenticateUser(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        // Check if biometric authentication is available on the device.
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Acces to the pokemons"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        // Authentication was successful, user is verified
                        completion(true)
                    } else {
                        // Authentication failed, proceed with fallback
                        completion(false)
                    }
                }
            }
        } else {
            // Biometric authentication not available
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }

    
    
}
