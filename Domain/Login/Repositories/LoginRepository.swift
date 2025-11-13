//
//  LoginRepository.swift
//  SpaceXInsights
//
//  Created by luisr on 10/11/25.
//

import Foundation

  protocol LoginRepository {
    
    func login(with credentials: UserCredentials) async throws -> Bool
    
}
