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
    private let stationsEndPoint = "\(AuthServiceEndPoint.BASE_URL.rawValue)/stations"
    private let avaibleSlotsEndPoint = "\(AuthServiceEndPoint.BASE_URL.rawValue)/stations"
    private let sendAppointmentRequestEndPoint = "\(AuthServiceEndPoint.BASE_URL.rawValue)/appointments/make"
    private let checkAppointmentstEndPoint = "\(AuthServiceEndPoint.BASE_URL.rawValue)/appointments"
    private let deleteAppointmentEndPoint = "\(AuthServiceEndPoint.BASE_URL.rawValue)/appointments/cancel"
    
    
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
                switch response.result {
                case .success(_):
                    TokenManager.shared.clearToken()
                    completion(true)
                    
                case .failure(let error):
                    completion(false)
                    print(error)
                }
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
    func fetchStations(completion: @escaping (Stations?) -> Void) {
        if let credintal = TokenManager.shared.getCredential() {
            let token = credintal.token!
            let userId = credintal.userID!
            let stationsUrl: URL!
            if LocationManager.shared.getLatitude() == nil {
                stationsUrl = URL(string: "\(stationsEndPoint)?userID=\(userId)")
            } else {
                stationsUrl = URL(string: "\(stationsEndPoint)?userID=\(userId)&userLatitude=\(LocationManager.shared.getLatitude()!)&userLongitude=\(LocationManager.shared.getLongitude()!)")
            }

            
            let headers: HTTPHeaders = [
                "Connection": "keep-alive",
                "token": token
            ]
            
            session?.request(stationsUrl!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseDecodable(of: Stations.self) { response in
                switch response.result {
                    
                case .success(let value):
                    completion(value)
                    
                case .failure(let error):
                    completion(nil)
                    print(error)
                }
            }
        }
    }
    func fetchAvaibleTimes(stationID: Int, date: String, completion: @escaping (Station?) -> Void) {
        if let credintal = TokenManager.shared.getCredential() {
            let token = credintal.token!
            let userId = credintal.userID!
            
            let slotsUrl = URL(string: "\(stationsEndPoint)/\(stationID)?userID=\(userId)&date=\(date)")
            
            let headers: HTTPHeaders = [
                "Connection": "keep-alive",
                "token": token
            ]
            
            session?.request(slotsUrl!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseDecodable(of: Station.self) { response in
                switch response.result {
                    
                case .success(let value):
                    completion(value)
                    
                case .failure(let error):
                    completion(nil)
                    print(error)
                }
            }
        }
    }
    func sendAppointmentRequest(stationID: Int, socketID: Int, timeSlot: String, appointmentDate: String, completion: @escaping (Bool) -> Void) {
        if let credintal = TokenManager.shared.getCredential() {
            let token = credintal.token!
            let userId = credintal.userID!
            
            let appointmentRequestUrl = URL(string: "\(sendAppointmentRequestEndPoint)?userID=\(userId)")
            
            let headers: HTTPHeaders = [
                "Connection": "keep-alive",
                "token": token
            ]
            session?.request(appointmentRequestUrl!, method: .post, parameters: ["stationID": stationID, "socketID": socketID, "timeSlot": timeSlot, "appointmentDate": appointmentDate], encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).response { response in
                print(response)
                switch response.result {
                case .success(_):
                    completion(true)
                    
                case .failure(let error):
                    completion(false)
                    print(error)
                }
            }
        }
    }
    func checkAppointments(completion: @escaping ([Appointment]?) -> Void) {
        if let credintal = TokenManager.shared.getCredential() {
            let token = credintal.token!
            let userId = credintal.userID!
            
            let appointmentsUrl: URL!
            if LocationManager.shared.getLatitude() == nil {
                appointmentsUrl = URL(string: "\(checkAppointmentstEndPoint)/\(userId)")
            } else {
                appointmentsUrl = URL(string: "\(checkAppointmentstEndPoint)/\(userId)?userLatitude=\(LocationManager.shared.getLatitude()!)&userLongitude=\(LocationManager.shared.getLongitude()!)")
            }
            
            let headers: HTTPHeaders = [
                "Connection": "keep-alive",
                "token": token
            ]
            
            session?.request(appointmentsUrl!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseDecodable(of: [Appointment].self) { response in
                switch response.result {
                    
                case .success(let value):
                    completion(value)
                    
                case .failure(let error):
                    completion(nil)
                    print(error)
                }
            }
        }
    }
    /// Delete Appointment
    func deleteApoointment(appointmentID: Int, completion: @escaping (Bool) -> Void) {
        if let credintal = TokenManager.shared.getCredential() {
            let token = credintal.token!
            let userId = credintal.userID!
            
            let deleteAppointmentUrl = URL(string: "\(deleteAppointmentEndPoint)/\(appointmentID)?userID=\(userId)")
            
            let headers: HTTPHeaders = [
                "Connection": "keep-alive",
                "token": token
            ]
            
            session?.request(deleteAppointmentUrl!, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).response { response in
                switch response.result {
                case .success(_):
                    completion(true)
                    
                case .failure(let error):
                    completion(false)
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

