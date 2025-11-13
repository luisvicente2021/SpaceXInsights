//
//  LoginUserRepository.swift
//  SpaceXInsights
//
//  Created by luisr on 10/11/25.
//

import Foundation

class LoginUserRepository:  LoginRepository {
    public init() {}
    
    
    func login(with credentials: UserCredentials) async throws -> Bool {
        
      //  let body = try JSONEncoder().encode(credentials)
        
        //let response: LoginResponseDTO = try await APIClient.shared.request(
          //  endpoint: "https://api.spacexdata.com/v3/launches/past",
           // method: "POST",
           // body: body,
           // headers: ["Content-Type": "application/json"],
           // responseType: LoginResponseDTO.self
        //)
        
        if credentials.email == "1" && credentials.password == "1" {
            return true
        } else {
            return false
        }
    }
    
    
    
}

struct LoginResponseDTO: Decodable {
    let success: Bool
    let token: String?
}
