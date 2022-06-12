//
//  ConversationViewModel.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 31/05/2022.
//

import SwiftUI

class ConversationViewModel:ObservableObject {
    let dataController:DataController = DataController()
    @Published var conversations:[Conversation] = []
    
    @MainActor
    public func conversationsList(token:String) async {
        if let userID = await dataController.getCurrentUser(token: token) {
            conversations = await dataController.getConversations(token: token, userID: userID.id)
        }
    }
}
