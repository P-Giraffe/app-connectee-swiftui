//
//  TokenViewModel.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 11/06/2022.
//

import Foundation
import SwiftUI

class TokenViewModel:ObservableObject {
    @Published var token:Token?
    @Published var expirationDate:Date = Date.now
    @Published var isConnected:Bool = false
    
    let dataController:DataController = DataController()
    
    @MainActor
    public func loginUser(email:String, pwd:String) async {
        token = await dataController.login(email: email, pwd: pwd)
        if let tokenFound = token {
            isConnected = true
            expirationDate = Date.now.addingTimeInterval(TimeInterval(tokenFound.expires/1000))
        }
    }
    
    @MainActor
    public func needRefresh() async {
        if(Date.now > expirationDate) {
            if let tokenExist = token {
                token = await dataController.refreshToken(token: tokenExist.refresh_token)
            }
        }
    }
    
}
