//
//  LoginUseCase.swift
//  SpaceXInsights
//
//  Created by luisr on 10/11/25.

enum LoginError: Error {
    
case invalidEmail
}
//

struct UserCredentials: Encodable {
    
    let email: String
    let password: String
}



struct LoginUserUseCase {
    
     let repository: LoginRepository
    
    
    func execute (credential: UserCredentials) async throws -> Bool {
        
      //  guard credential.email.contains("@") else {
            
        //    throw LoginError.invalidEmail
       // }
   print("prueba useCase")    
        
        return try await repository.login(with: credential)
        
    }
}
