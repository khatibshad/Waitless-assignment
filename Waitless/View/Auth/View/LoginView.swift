//
//  LoginView.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                VStack {
                    Image("logo")
                    WATextView(text: "Waitless\nER", style: .custom(style: .init(font: .title, normalColor: .white, selectedColor: nil, disabledColor: nil)), multilineAlignment: .center)
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .background(Color.red)
                VStack {
                    VStack(alignment: .leading, spacing: 24) {
                        WATextField(placeholder: "Username", text: $email)
                        WATextField(placeholder: "Password", text: $email, isSecure: true)
                        WATextView(text: "Forgot Password?", style: .caption, multilineAlignment: .trailing)
                        WAButtonView(title: "Login", action: {
                            
                        })
                        WATextView(text: "Don’t have an account? Sign up", style: .caption, multilineAlignment: .center)
                            .frame( maxWidth: .infinity, alignment: .center)
                        WAButtonView(title: "Sign In With Google",action: {
                            
                        }, style: .border(bgColor: .white, textColor: .red, borderColor: .red))
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(
                        RoundedCorner(radius: 14, corners: [.topLeft, .topRight])
                    )
                    .padding()
                    
                }
                .offset(y: -50)
                
                Spacer()
            }
            
        }
        .navigationTitle("Profile")
    }
    
    
    
}

#Preview {
    LoginView()
}
