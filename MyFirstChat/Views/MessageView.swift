//
//  MessageView.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 01/06/2022.
//

import SwiftUI

struct MessageView: View {
    @StateObject var messageViewModel:MessageViewModel
    @EnvironmentObject var tokenViewModel:TokenViewModel
    @State var typingMessage:String = ""
    var body: some View {
        List(messageViewModel.messages, id:\.id) { item in
            Text("\(item.user_created.last_name) \(item.user_created.first_name)")
                .bold()
            Text("\(item.Content)")
        }
        HStack {
            TextField("Message", text:$typingMessage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(minHeight:CGFloat(30))
                .padding()
            Button {
                Task {
                    await tokenViewModel.needRefresh()
                    if let tokenFound = tokenViewModel.token {
                        await messageViewModel.sendMessage(content: typingMessage, token: tokenFound.access_token)
                        await messageViewModel.messagesList(token: tokenFound.access_token)
                    }
                }
                
            } label: {
                Text("Send")
            }.frame(minHeight: CGFloat(50)).padding()

        }
    }
}
