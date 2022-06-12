//
//  DataController.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 31/05/2022.
//

import Foundation

struct ResponseConversation:Decodable {
    var data:[Conversation]
}

struct ResponseMessage:Decodable {
    var data:[Message]
}

struct DataController {
    public func getConversations() async -> [Conversation] {
        var conversations:[Conversation] = []
        let request = "https://directus.myjobly.fr/items/Conversations?fields=id,user_created.last_name,user_created.first_name,user_created.id,Messages.user_created.last_name,Messages.user_created.first_name,Messages.user_created.id,user_created.email,Messages.user_created.email,Messages.id,Messages.Content,Messages.date_created,Messages.status,Messages.Conversation,Contributors.directus_users_id.last_name,Contributors.directus_users_id.first_name,Contributors.directus_users_id.id,Contributors.directus_users_id.email,date_created,date_updated"
        
        let session = URLSession.shared
        
        guard let url = URL(string: request) else {
            return []
        }
        
        do {
            let (data, _) = try await session.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(ResponseConversation.self, from: data) {
                conversations = decodedResponse.data
            } else {
                print("Unable to fetch data")
            }
        } catch {
            print("invalid data")
        }
        return conversations
    }
    
    public func getMessages(conversation:UUID) async -> [Message] {
        var messages:[Message] = []
        let request = "https://directus.myjobly.fr/items/Conversations?fields=Messages.user_created.last_name,Messages.user_created.first_name,Messages.user_created.id,Messages.user_created.email,Messages.id,Messages.Content,Messages.date_created,Messages.status,Messages.Conversation&filter[Messages][Conversation][_eq]=\(conversation)"
        
        let session = URLSession.shared
        
        guard let url=URL(string: request) else {
            return []
        }
        
        do {
            let (data, _) = try await session.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(ResponseMessage.self, from: data) {
                messages = decodedResponse.data
            } else {
                print("Unable to fetch data")
            }
        } catch {
            print("invalid data")
        }
        return messages
    }
}
