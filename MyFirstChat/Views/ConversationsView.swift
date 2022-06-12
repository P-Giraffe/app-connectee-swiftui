//
//  ConversationsView.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 31/05/2022.
//

import SwiftUI

struct ConversationsView: View {
    @StateObject var conversationViewModel:ConversationViewModel = ConversationViewModel()
    
    var body: some View {
        NavigationView {
        List(conversationViewModel.conversations, id: \.id) { item in
            NavigationLink(destination: MessageView(messageViewModel: MessageViewModel(messages: item.Messages, conversationId: item.id))) {
                Label("\(item.Contributors.first!.directus_users_id.last_name) \(item.Contributors.first!.directus_users_id.first_name)",systemImage: "person.3")
            }
            
        }
        .task {
            await conversationViewModel.conversationsList()
        }
        }
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
    }
}
