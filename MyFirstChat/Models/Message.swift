//
//  Message.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 26/05/2022.
//

import Foundation

struct Message:Decodable {
    let id:UUID
    let Content:String
    let date_created:String
    let user_created:User
    let status:String
    let Conversation:UUID
}
