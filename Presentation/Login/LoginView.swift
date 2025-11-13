//
//  SwiftUIView.swift
//  SpaceXInsights
//
//  Created by luisr on 02/06/25.
//

import SwiftUI

struct LoginView: View {

    @StateObject var viewModel: LoginViewModel
    var onLoginSuccess: (() -> Void)?
    var strings = Strings()
    let spaceship = "spaceship"
    @State private var email = ""
    @State private var password = ""
    

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Image(spaceship)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 24)
                
                TextField(strings.emailPlaceholder, text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .onChange(of: email) { newValue in
                        email = newValue.lowercased()
                    }
                    .padding()
                    .frame(height: 56)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                SecureField(strings.passwordPlaceholder, text: $password)
                    .padding()
                    .frame(height: 56)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

              /*  if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                }*/

                Button(action: {
                    
                    print("Email antes de login:", email)
                        print("Password antes de login:", password)
                    Task {
                        await viewModel.login(email: email, password: password)
                    }
                }) {
                    Text(strings.loginButtonTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
               // .disabled(viewModel.isLoading)
                
                Spacer()
            }
            .padding()
            
          /*/  if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }*/
        }
    }
}
