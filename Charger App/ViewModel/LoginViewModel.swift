//
//  LoginViewModel.swift
//  Charger App
//
//  Created by Doğukan Inci on 1.07.2022.
//

import Foundation

class LoginViewModel {
    
    // Singleton
    static let shared = LoginViewModel()
    
    var eMail: String?
    
    // E-mail check validity and save
    func saveMail(eMailTextField: String) -> Bool {
        if isValidEmail(eMailTextField) {
            eMail = eMailTextField
            return true
        } else  {
            return false
        }
        
    }
    func fetchToken(completion: @escaping (Bool) -> () ) {
        ChargerService.shared.fetchAccessToken(eMailAddress: eMail!, deviceUDID: TokenManager.shared.deviceUDID,
                                            completion: { isSuccess in
            !isSuccess ? completion(false) : completion(true)
        })
    }
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
