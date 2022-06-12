//
//  Conversation.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 26/05/2022.
//

import Foundation

struct DirectusUsersID:Decodable {
    let directus_users_id:User
}

struct Conversation:Decodable {
    let id:UUID
    let date_created:String
    let date_updated:String?
    let user_created:User
    var Messages:[Message]
    var Contributors:[DirectusUsersID]
}
