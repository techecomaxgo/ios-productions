//
//  EncryptionService.swift
//  CryptoTest
//
//  Created by Admin on 17/12/24.
//

import Foundation
import CryptoKit

class EncryptionService {
    
    static let shared = EncryptionService()

    
    // Generate random IV for AES-GCM (12 bytes)
    static func generateRandomIV() -> Data {
        return Data((0..<12).map { _ in UInt8.random(in: 0...255) })
    }

    // Extract the last 32 bytes from the JWT token
    static func getLast32Bytes(_ jwtToken: String) -> Data? {
        guard jwtToken.count >= 32 else { return nil }
        let startIndex = jwtToken.index(jwtToken.endIndex, offsetBy: -32)
        let last32Bytes = jwtToken[startIndex...]
        return Data(last32Bytes.utf8)
    }
    
    func convertDictToJsonString(dictionary: NSDictionary) -> String?  {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON String: \(jsonString)")
                return jsonString
                
            }
        } catch {
            print("Error converting dictionary to JSON: \(error.localizedDescription)")
            return nil
        }
        return ""

    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func finalParam(_ params: NSDictionary) -> NSDictionary {
        let string = convertDictToJsonString(dictionary: params)
        let result = try! encrypt(message: string ?? "", jwtToken: Common.shared.token ?? "")
        print(result)
        
        let finalBase64String = convertToDictAsBase64(encrypted: result.encrypted, authTag: result.authTag, iv: result.iv)!
                
        let finalParam : NSDictionary  = ["data":finalBase64String]
        print("The dictionary is : \(finalParam)")
        return finalParam
    }
    
    func convertToDictAsBase64(encrypted: String, authTag: String, iv: String) -> String? {

        // Create dictionary with encrypted components
        let dict: [String: String] = [
            "encrypted": encrypted,
            "authTag": authTag,
            "iv": iv
        ]

        // Serialize dictionary to JSON and encode as Base64
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return jsonData.base64EncodedString()
        } catch {
            print("Serialization to JSON failed: \(error)")
            return nil
        }
    }

    // Encrypt message function using AES-GCM
    func encrypt(message: String, jwtToken: String) throws -> (encrypted: String, authTag: String, iv: String) {
        do {
            // Generate key and IV
            let key: SymmetricKey
            if let jwtKey = EncryptionService.getLast32Bytes(jwtToken) {
                key = SymmetricKey(data: jwtKey)
            } else {
                // Fallback to generating a random 256-bit key if JWT key is not valid
                key = SymmetricKey(size: .bits256)
            }

            // Generate a random 12-byte IV
            let iv = EncryptionService.generateRandomIV()

            // Create an AES-GCM cipher and seal the message
            guard let messageData = message.data(using: .utf8) else {
                throw NSError(domain: "EncryptionError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Message encoding failed"])
            }
            
            let sealedBox = try AES.GCM.seal(messageData, using: key, nonce: AES.GCM.Nonce(data: iv))
            
            // Return encrypted data, authentication tag, and IV as base64-encoded strings
            return (
                encrypted: sealedBox.ciphertext.base64EncodedString(),
                authTag: sealedBox.tag.base64EncodedString(),
                iv: iv.base64EncodedString()
            )
        } catch {
            print("Encryption error: \(error)")
            throw NSError(domain: "EncryptionError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Encryption failed"])
        }
    }
    // Decrypt message function using AES-GCM
        func decrypt(encrypted: String, iv: String, authTag: String, jwtToken: String) throws -> String? {
            do {
                // Generate key from the current JWT token or use a random key if the JWT token is invalid
                let key: SymmetricKey
                if let jwtKey = EncryptionService.getLast32Bytes(jwtToken) {
                    key = SymmetricKey(data: jwtKey)
                } else {
                    // Fallback to generating a random 256-bit key if JWT key is not valid
                    key = SymmetricKey(size: .bits256)
                }

                // Convert the IV, authentication tag, and encrypted message from base64
                guard let nonceData = Data(base64Encoded: iv), nonceData.count == 12 else {
                    throw NSError(domain: "DecryptionError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid IV (nonce) length. It must be 12 bytes."])
                }
                let nonce = try AES.GCM.Nonce(data: nonceData)

                guard let tag = Data(base64Encoded: authTag) else {
                    throw NSError(domain: "DecryptionError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid authentication tag."])
                }

                guard let ciphertext = Data(base64Encoded: encrypted) else {
                    throw NSError(domain: "DecryptionError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Invalid encrypted data."])
                }

                // Create the SealedBox for decryption
                let sealedBox = try AES.GCM.SealedBox(nonce: nonce, ciphertext: ciphertext, tag: tag)
                
                // Decrypt the data using AES-GCM
                let decryptedData = try AES.GCM.open(sealedBox, using: key)

                // Convert decrypted data back to a string
                guard let decryptedMessage = String(data: decryptedData, encoding: .utf8) else {
                    throw NSError(domain: "DecryptionError", code: 4, userInfo: [NSLocalizedDescriptionKey: "Failed to decode the decrypted message into a string."])
                }

                return decryptedMessage
            } catch {
                print("Decryption error: \(error)")
                throw NSError(domain: "DecryptionError", code: 5, userInfo: [NSLocalizedDescriptionKey: "Decryption failed"])
            }
        }
    
}
