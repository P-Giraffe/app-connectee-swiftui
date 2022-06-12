//
//  MessageViewModel.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 01/06/2022.
//

import SwiftUI

class MessageViewModel:ObservableObject {
    @Published var messages:[Message]
    let conversationId:UUID
    let dataController:DataController = DataController()
    
    init(messages:[Message], conversationId:UUID) {
        self.conversationId = conversationId
        self.messages = messages
    }
    
    @MainActor
    public func messagesList(token:String) async {
        messages = await dataController.getMessages(conversation: conversationId,token:token)
    }
}
