//
//  AuthViewModel.swift
//  SpaceXInsights
//
//  Created by luisr on 02/06/25.
//

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

