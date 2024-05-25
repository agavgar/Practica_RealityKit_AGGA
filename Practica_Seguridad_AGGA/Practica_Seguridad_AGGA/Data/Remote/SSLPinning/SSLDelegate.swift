//
//  SSLDelegate.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 24/5/24.
//

import Foundation
import CryptoKit

final class SSLDelegate: NSObject {
    
    private let crypto: Crypto
    
    override init() {
        self.crypto = Crypto()
    }
    
}

extension SSLDelegate: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Server trust
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLDelegate -> Error -> no serverTrust")
            return
        }
        let serverCertificates: [SecCertificate]?
        serverCertificates = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate]
        guard let serverCertificate = serverCertificates?.first else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLDelegate -> Error -> ServerCertificates")
            return
        }
        
        guard let serverPublicKey = SecCertificateCopyKey(serverCertificate) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLDelegate -> Error -> Public Key")
            return
        }
        
        guard let serverPublicKeyRep = SecKeyCopyExternalRepresentation(serverPublicKey, nil) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLDelegate -> Error -> Public Key to Data")
            return
        }
        let serverPublicKeyData = serverPublicKeyRep as Data
        let serverHashBase64 = sha256CryptoKit(data: serverPublicKeyData)
        let localKeyHashBase64 = self.crypto.getLocalServerKey()
        //print(serverHashBase64)
        //print(localKeyHashBase64)
        
        if serverHashBase64 == localKeyHashBase64 {
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        }else{
            // Try on ZAP.
            print("SSLDelegate -> Error -> Public Key diferent with LocalServerKey")
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}

extension SSLDelegate {
    
    private func sha256CryptoKit(data: Data) -> String {
        let hash = SHA256.hash(data: data)
        return Data(hash).base64EncodedString()
    }
    
}
