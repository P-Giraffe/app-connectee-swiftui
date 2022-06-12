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

struct ResponseToken:Decodable {
    var data:Token
}

struct ResponseUser:Decodable {
    var data:User
}

struct ResponseMessage:Decodable {
    var data:[Message]
}

struct DataController {
    public func login(email:String,pwd:String) async -> Token? {
        var token:Token?
        let request = "https://directus.myjobly.fr/auth/login"
        
        let session = URLSession.shared
        
        guard let url = URL(string: request) else {
            return nil
        }
        
        var tokenRequest = URLRequest(url: url)
        tokenRequest.httpMethod = "POST"
        
        let tokenBody = [
            "email":"\(email)",
            "password":"\(pwd)"
        ]
        
        let body = try? JSONSerialization.data(withJSONObject: tokenBody, options: [])
        
        tokenRequest.httpBody = body
        tokenRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await session.data(for: tokenRequest)
            
            if let decodedResponse = try? JSONDecoder().decode(ResponseToken.self, from: data) {
                token = decodedResponse.data
            } else {
                print("Unable to fetch data")
            }
        } catch {
            print("invalid data")
        }
        
        return token
    }
    
    public func refreshToken(token:String) async -> Token? {
        var refreshToken:Token?
        let request = "https://directus.myjobly.fr/auth/refresh"
        
        let session = URLSession.shared
        
        guard let url = URL(string: request) else {
            return nil
        }
        
        var tokenRequest = URLRequest(url: url)
        tokenRequest.httpMethod = "POST"
        
        let tokenBody = [
            "refresh_token":"\(token)"
        ]
        
        let body = try? JSONSerialization.data(withJSONObject: tokenBody, options: [])
        
        tokenRequest.httpBody = body
        tokenRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await session.data(for: tokenRequest)
            
            if let decodedResponse = try? JSONDecoder().decode(ResponseToken.self, from: data) {
                refreshToken = decodedResponse.data
            } else {
                print("Unable to fetch data")
            }
        } catch {
            print("invalid data")
        }
        
        return refreshToken
    }
    
    public func getConversations(token:String, userID:UUID) async -> [Conversation] {
        var conversations:[Conversation] = []
        let request = "https://directus.myjobly.fr/items/Conversations?fields=id,user_created.last_name,user_created.first_name,user_created.id,Messages.user_created.last_name,Messages.user_created.first_name,Messages.user_created.id,user_created.email,Messages.user_created.email,Messages.id,Messages.Content,Messages.date_created,Messages.status,Messages.Conversation,Contributors.directus_users_id.last_name,Contributors.directus_users_id.first_name,Contributors.directus_users_id.id,Contributors.directus_users_id.email,date_created,date_updated&deep[Contributors][_filter][directus_users_id][id][_neq]=\(userID)"
        
        let session = URLSession.shared
        
        guard let url = URL(string: request) else {
            return []
        }
        
        var getRequest = URLRequest(url: url)
        getRequest.httpMethod = "GET"
        getRequest.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await session.data(for: getRequest)
            
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
    
    public func getMessages(conversation:UUID, token:String) async -> [Message] {
        var messages:[Message] = []
        let request = "https://directus.myjobly.fr/items/Conversations?fields=Messages.user_created.last_name,Messages.user_created.first_name,Messages.user_created.id,Messages.user_created.email,Messages.id,Messages.Content,Messages.date_created,Messages.status,Messages.Conversation&filter[Messages][Conversation][_eq]=\(conversation)"
        
        let session = URLSession.shared
        
        guard let url=URL(string: request) else {
            return []
        }
        
        var getRequest = URLRequest(url: url)
        getRequest.httpMethod = "GET"
        getRequest.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
    
    public func getCurrentUser(token:String) async -> User? {
        var currentUser:User?
        let request = "https://directus.myjobly.fr/users/me"
        
        let session = URLSession.shared
        
        guard let url=URL(string: request) else {
            return nil
        }
        
        var getRequest = URLRequest(url: url)
        getRequest.httpMethod = "GET"
        getRequest.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        print("\(token)")
        do {
            let (data, _) = try await session.data(for: getRequest)
            if let decodedResponse = try? JSONDecoder().decode(ResponseUser.self, from: data) {
                currentUser = decodedResponse.data
            } else {
                print("Unable to fetch data")
            }
        } catch {
            print("invalid data")
        }
        
        return currentUser
    }
}
