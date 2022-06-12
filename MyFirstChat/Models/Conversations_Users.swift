//
//  Conversations_Users.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 26/05/2022.
//

import Foundation

struct Conversations_Users:Decodable {
    let Conversations_id:UUID
    let directus_users_id:UUID
    let id:Int
}
