//
//  AuthViewModel.swift
//  SpaceXInsights
//
//  Created by luisr on 02/06/25.
//

import Foundation
/*
import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    var strings = Strings()

    func login(onSuccess: @escaping () -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            self.errorMessage = strings.emptyFieldsError
                    return
                }

        isLoading = true
        errorMessage = nil

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    onSuccess()
                }
            }
        }
    }
}

*/

class LoginViewModel: ObservableObject {
    
    var useCase: LoginUserUseCase
    @Published var  isLoggedIn = false
    var onLoginSuccess: (() -> Void)?
                         
    init (useCase: LoginUserUseCase) {
        self.useCase = useCase
    }
    
    @MainActor
    func login(email: String, password: String) async {
        
        print("se ejecuta login")
        
        let creds = UserCredentials(email: email, password: password)
        print(email)
        print(password)
        
        do {
            
            
            let success = try await useCase.execute(credential: creds)
            print(success)
            if success {
                print("correcto login")
                onLoginSuccess?()
            }
        } catch LoginError.invalidEmail{
                print("Login incorrecto")
                
            }
        catch {
            print("otro error", error.localizedDescription)
        }
        }
        
        //isLoggedIn = (try? await useCase.execute (credential: creds)) ?? false
    }
