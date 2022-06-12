//
//  ConversationsView.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 31/05/2022.
//

import SwiftUI

struct ConversationsView: View {
    @StateObject var conversationViewModel:ConversationViewModel = ConversationViewModel()
    @EnvironmentObject var tokenViewModel:TokenViewModel
    
    var body: some View {
        NavigationView {
        List(conversationViewModel.conversations, id: \.id) { item in
            NavigationLink(destination: MessageView(messageViewModel: MessageViewModel(messages: item.Messages, conversationId: item.id))) {
                Label("\(item.Contributors.first!.directus_users_id.last_name) \(item.Contributors.first!.directus_users_id.first_name)",systemImage: "person.3")
            }
            
        }
        .navigationTitle("Mes conversations")
        .task {
            await tokenViewModel.needRefresh()
            if let tokenFound = tokenViewModel.token {
                await conversationViewModel.conversationsList(token: tokenFound.access_token)
            }
        }
        }
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
    }
}
