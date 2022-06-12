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
    
    public func conversationsList() async {
        conversations = await dataController.getConversations()
    }
}
