//
//  ContentView.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 25/05/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var tokenViewModel:TokenViewModel = TokenViewModel()
    var body: some View {
        if tokenViewModel.isConnected {
            ConversationsView()
                .environmentObject(tokenViewModel)
        }else{
            Login()
                .environmentObject(tokenViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
    }
}
