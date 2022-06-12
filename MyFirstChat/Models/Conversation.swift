//
//  Conversation.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 26/05/2022.
//

import Foundation

struct Conversation:Decodable {
    let id:UUID
    let date_created:String
    var Messages:[UUID]
    var Contributors:[Int]
}
