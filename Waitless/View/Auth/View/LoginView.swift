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
                    WATextView(text: "Waitless\nER", style: .custom(style: .init(font: .system(size: 32, weight: .bold), normalColor: .white, selectedColor: .white, disabledColor: .white)), textColor: .white, multilineAlignment: .center)
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .background(Color.main)
                VStack {
                    VStack(alignment: .leading, spacing: 24) {
                        WATextField(placeholder: "Username", text: $email)
                        WATextField(placeholder: "Password", text: $email, isSecure: true)
                        WATextView(text: "Forgot Password?", style: .caption, textColor: .textBlack, multilineAlignment: .trailing)
                        WAButtonView(title: "Sign in", action: {
                            
                        })
                        HStack(alignment: .center, spacing: 0) {
                            WATextView(text: "Don’t have an account? ", style: .caption, textColor: .textGray, multilineAlignment: .center)
                            WATextView(text: "Sign up", style: .caption, multilineAlignment: .center)
                        }
                        .frame( maxWidth: .infinity, alignment: .center)
                        .onTapGesture {
                            
                        }

                        WAButtonView(title: "Sign In With Google",action: {
                            
                        }, style: .border(bgColor: .white, textColor: .main, borderColor: .main))
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
        .onAppear {
        }
    }
    
    
    
}

#Preview {
    LoginView()
}
