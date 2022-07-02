//
//  LoginService.swift
//  Charger App
//
//  Created by Doğukan Inci on 1.07.2022.
//

import Alamofire
import Foundation

class LoginService {
    
    // Singleton
    static let shared = LoginService()
    
    // URL
    private let loginUrl = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/login")
    
    var session: Session?
    
    // Post method for Login
    func fetchAccessToken(
        eMailAddress  : String,
        deviceUDID: String,
        completion: @escaping (Bool) -> Void) {
            
            let headers: HTTPHeaders = [
                "Connection": "keep-alive",
                "Content-Type": "application/json"
            ]
            let configuration = URLSessionConfiguration.af.default
            configuration.timeoutIntervalForRequest = 30
            configuration.waitsForConnectivity = true
            let evaluators: [String: ServerTrustEvaluating] = [
                // By default, certificates included in the app bundle are pinned automatically.
                "cert.example.com": PinnedCertificatesTrustEvaluator(),
                // By default, public keys from certificates included in the app bundle are used automatically.
                "keys.example.com": PublicKeysTrustEvaluator(),
            ]
            let manager = ServerTrustManager(evaluators: evaluators)
            self.session = Session(configuration: configuration,serverTrustManager: manager)
            session?.request(loginUrl!, method: .post, parameters: ["email": eMailAddress, "deviceUDID": deviceUDID], encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseDecodable(of: AccessToken.self) { response in
                guard let cred = response.value else {
                    return completion(false)
                }
                TokenManager.shared.saveAccessToken(cred: cred)
                completion(true)
            }
        }
}

