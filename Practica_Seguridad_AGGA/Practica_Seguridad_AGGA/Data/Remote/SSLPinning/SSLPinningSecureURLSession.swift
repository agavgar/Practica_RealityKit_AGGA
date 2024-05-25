//
//  SSLPinningSecureURLSession.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 24/5/24.
//

import Foundation

final class SSLPinningSecureURLSession {
    
    let session: URLSession
    
    init() {
        self.session = URLSession(configuration: .ephemeral, delegate: SSLDelegate(), delegateQueue: nil)
    }
}

extension URLSession {
    
    // THIS DOESN'T WORKED FOR ME, BUT I INJECTED IT DIRECTLY IN THE APIPROVIDER FUNCTION
    
    static var share: URLSession {
        return SSLPinningSecureURLSession().session
    }
}
