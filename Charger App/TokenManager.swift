//
//  TokenManager.swift
//  Charger App
//
//  Created by Doğukan Inci on 2.07.2022.
//

import Foundation

class TokenManager {
    // Singleton
    static let shared = TokenManager()
    
    //Save token to User Defaults
    func saveAccessToken(cred: AccessToken) {
        do {
            let cred = try JSONEncoder().encode(cred)
            UserDefaults.standard.set(cred, forKey: "Cred")
        } catch {
            print("Unable to Encode Credential (\(error))")
        }
    }
    // Get token from User Defaults
    func getCredential() -> AccessToken? {
        if let data = UserDefaults.standard.data(forKey: "Cred") {
            do {
                let cred = try JSONDecoder().decode(AccessToken.self, from: data)
                return cred
            } catch {
                print("Unable to Decode Credential (\(error))")
            }
        }
        else {
            print("Unable to read User Default for Cred")
        }
        return nil
    }
}
