//
//  LoginService.swift
//  Charger App
//
//  Created by Doğukan Inci on 1.07.2022.
//

import Alamofire
import Foundation

class ChargerService {
    
    init() {
        setupSession()
    }
    
    // Singleton
    static let shared = ChargerService()
    
    // EndPoint
    enum AuthServiceEndPoint: String {
        case BASE_URL = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080"
        case PATH = "/auth"
        
        static func authServiceUrl() -> String {
            return "\(BASE_URL.rawValue)\(PATH.rawValue)"
        }
    }
    // URL
    private let loginUrl = URL(string: "\(AuthServiceEndPoint.authServiceUrl())/login")
    private let logoutUrlEndpoint = "\(AuthServiceEndPoint.authServiceUrl())/logout"
    private let citiesUrlEndpoint = "\(AuthServiceEndPoint.BASE_URL.rawValue)/provinces"
    
    
    var session: Session?
    
    /// Post method for Login
    func fetchAccessToken(eMailAddress : String, deviceUDID: String, completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Connection": "keep-alive",
            "Content-Type": "application/json"
        ]
        
        session?.request(loginUrl!, method: .post, parameters: ["email": eMailAddress, "deviceUDID": deviceUDID], encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseDecodable(of: AccessToken.self) { response in
            
            switch response.result {
                
            case .success(let value):
                let cred = value
                TokenManager.shared.saveAccessToken(cred: cred)
                completion(true)

            case .failure(let error):
                completion(false)
                print(error)
            }
        }
    }
    /// Post method for logout
    func logout(completion: @escaping (Bool) -> Void) {
        if let credintal = TokenManager.shared.getCredential() {
            let token = credintal.token!
            let userId = credintal.userID!
            
            let logoutUrl = URL(string: "\(logoutUrlEndpoint)/\(userId)")
            
            let headers: HTTPHeaders = [
                "Connection": "keep-alive",
                "token": token
            ]
            
            session?.request(logoutUrl!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).response { response in
                print(response.debugDescription)
                TokenManager.shared.clearToken()
                completion(true)
            }
        }
    }
    func fetchCities(completion: @escaping ([String]?) -> Void) {
        if let credintal = TokenManager.shared.getCredential() {
            let token = credintal.token!
            let userId = credintal.userID!
            
            let citiesUrl = URL(string: "\(citiesUrlEndpoint)?userID=\(userId)")
            
            let headers: HTTPHeaders = [
                "Connection": "keep-alive",
                "token": token
            ]
            
            session?.request(citiesUrl!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseDecodable(of: [String].self) { response in
                print(response.debugDescription)
                switch response.result {
                    
                case .success(let value):
                    let cities = value
                    completion(cities)

                case .failure(let error):
                    completion(nil)
                    print(error)
                }
            }
        }
    }
}
extension ChargerService {
    /// Create session instance with configuration
    func setupSession() {
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
    }
}

