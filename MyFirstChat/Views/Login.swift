//
//  Login.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 11/06/2022.
//

import SwiftUI

struct Login: View {
    @State var email:String = ""
    @State var pwd:String = ""
    @EnvironmentObject var tokenViewModel: TokenViewModel
    
    var body: some View {
        VStack {
            Text("My First Chat")
                .font(.largeTitle)
                .foregroundColor(Color.purple)
            TextField("Enter your email", text: $email)
            SecureField("Enter your password", text: $pwd)
            Button {
                Task {
                    await tokenViewModel.loginUser(email: email, pwd: pwd)
                }
            } label: {
                Text("Se Connecter")
                    .padding()
            }
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }.padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
