//
//  SwiftUIView.swift
//  SpaceXInsights
//
//  Created by luisr on 02/06/25.
//

import SwiftUI
import FirebaseAuth
import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    var onLoginSuccess: (() -> Void)?
    var strings = Strings()
    let spaceship = "spaceship"

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Image(spaceship)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 24)
                
                TextField(strings.emailPlaceholder, text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .onChange(of: viewModel.email) { newValue in
                        viewModel.email = newValue.lowercased()
                    }
                    .padding()
                    .frame(height: 56)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                SecureField(strings.passwordPlaceholder, text: $viewModel.password)
                    .padding()
                    .frame(height: 56)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button(action: {
                    viewModel.login {
                        onLoginSuccess?()
                    }
                }) {
                    Text(strings.loginButtonTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .disabled(viewModel.isLoading)
                
                Spacer()
            }
            .padding()
            
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }
        }
    }
}
