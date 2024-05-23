//
//  RootViewModel.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 23/5/24.
//

import Foundation
import LocalAuthentication

final class RootViewModel: ObservableObject {
    
    func authenticateUser(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify to access the app"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        completion(true)
                    }
                }
            }
        }
    }
    
}
