//
//  Crypto.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 24/5/24.
//

import Foundation
import CryptoKit

enum AESKeySize: Int {
    case bits128 = 16
    case bits192 = 24
    case bits256 = 32
}

final class Crypto {
    
    private let sealedDataBox = "HawxfOdQpxw3+8lyjGRAlPFcDY/7Mdlr3QiiRi7NHjNGi4U8kLEw+4qENqkds4pyi4NQl4cx"
    private let shinny = "YX0IgcwDd2m/iZH5iCcVqIKV1YZuWAIerdVPYM5WN0NgHf49vAc="
    private var localPublicKeyHashBase64 = "&nbOu-/;s~A$gk ydkC.(h-+0$9,{?sWIifg6:Fp/-?q"

    
    private func paddedKey_PKCS7(from key: String, withSize size: AESKeySize = .bits256) -> Data {
        guard let keyData = key.data(using: .utf8) else { return Data() }
        if(keyData.count == size.rawValue) {return keyData}
        if(keyData.count > size.rawValue) {return keyData.prefix(size.rawValue)}
        let paddingSize = size.rawValue - keyData.count % size.rawValue
        let paddingByte: UInt8 = UInt8(paddingSize)
        let padding = Data(repeating: paddingByte, count: paddingSize)
        return keyData + padding
    }
    
    private func encrypt(input: Data, key: String) -> Data {
        do {
            let keyData = paddedKey_PKCS7(from: key, withSize: .bits128)
            let key = SymmetricKey(data: keyData)
        
            let sealed = try AES.GCM.seal(input, using: key)
            return sealed.combined!
            
        }catch{
            return "Error -> Crypto -> encrypt".data(using: .utf8)!
        }
    }
    
    private func decrypt(input: Data, key: String) -> Data {
        do {
            let keyData = paddedKey_PKCS7(from: key, withSize: .bits128)
            let key = SymmetricKey(data: keyData)
            
            let sealed = try AES.GCM.SealedBox(combined: input)
            let opened = try AES.GCM.open(sealed, using: key)
            return opened
            
        }catch{
            return "Error -> Crypto -> Dencrypt".data(using: .utf8)!
        }
    }
    
    private func decryptedKey() -> String? {
        guard let shinnyDataKey = Data(base64Encoded: shinny) else {
            print("Crypto -> URLDecrypt -> sealedbox")
            return nil
        }
        let shinnyData = decrypt(input: shinnyDataKey, key: "")
        let shinnyString = String(data: shinnyData, encoding: .utf8)
        return shinnyString
    }
    
    public func getDecryptedURL () -> String? {
        guard let sealedDataBoxData = Data(base64Encoded: sealedDataBox) else {
            print("Crypto -> URLDecrypt -> sealedbox")
            return nil
        }
        let data = decrypt(input: sealedDataBoxData, key: decryptedKey()!)
        return String(data: data, encoding: .utf8)
    }
    
    //Needed help of chatgpt. The concept is the next one. A basic shift of the letters depending of the key. Example:
    // M = 13, A = 1, S = 20... masterballmasterball.
    // The key, the first letter is M, position 13, we shift it as it was 1 (Ex A) and the public was X umber 23. So now X is 12, so it is an L but in ascii &.
    // repeat whit each letter. X(M)M(A)/(S)z(T)P(E)Z(R)l(B)y(A)G(L)R(L)s(M)b(A)4(S)7(T)Z(E)G(R)B(B)J(A)v(L)a(L)...
    
    private func keyOfuscationMethodEncrypt(message: String, key: String) -> String {
        let keyShifts = key.map { $0.asciiValue! - Character("A").asciiValue! + 1 }
        var encryptedMessage = ""
        
        for (index, char) in message.enumerated() {
            let keyIndex = index % key.count
            let shiftAmount = Int(keyShifts[keyIndex])
            
            if let ascii = char.asciiValue {
                var newAscii = Int(ascii) + shiftAmount
                
                // Ensuring the new character wraps around within the ASCII printable range
                if newAscii > 126 { // 126 is '~'
                    newAscii = 32 + (newAscii - 127) // 32 is space
                }
                
                if let newChar = UnicodeScalar(newAscii) {
                    encryptedMessage.append(Character(newChar))
                } else {
                    encryptedMessage.append(char) // Append original character if new one isn't valid
                }
            } else {
                encryptedMessage.append(char) // Append original if non-ASCII
            }
        }
        
        return encryptedMessage
    }
    
    private func keyOfuscationMethodDencrypt(encryptedMessage: String, key: String) -> String {
        let keyShifts = key.map { $0.asciiValue! - Character("A").asciiValue! + 1 }
        var decryptedMessage = ""

        for (index, char) in encryptedMessage.enumerated() {
            let keyIndex = index % key.count
            let shiftAmount = Int(keyShifts[keyIndex])
            
            if let ascii = char.asciiValue {
                var newAscii = Int(ascii) - shiftAmount
                
                // Ensuring the new character wraps around within the ASCII printable range
                if newAscii < 32 { // 32 is space
                    newAscii = 127 - (32 - newAscii) // 127 is '~'
                }
                
                if let newChar = UnicodeScalar(newAscii) {
                    decryptedMessage.append(Character(newChar))
                } else {
                    decryptedMessage.append(char) // Append original character if new one isn't valid
                }
            } else {
                decryptedMessage.append(char) // Append original if non-ASCII
            }
        }
        
        return decryptedMessage
    }

    public func getLocalServerKey () -> String? {
        //print(self.localPublicKeyHashBase64)
        let localPublicKeyHashBase64 = keyOfuscationMethodDencrypt(encryptedMessage: self.localPublicKeyHashBase64, key: decryptedKey()!)
        //print(localPublicKeyHashBase64)
        return localPublicKeyHashBase64
    }
    
}
