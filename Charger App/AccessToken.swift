//
//  accessToken.swift
//  Charger App
//
//  Created by Doğukan Inci on 2.07.2022.
//

import Foundation
// MARK: - AccessToken
struct AccessToken: Codable {
    let email, token: String?
    let userID: Int?
}
