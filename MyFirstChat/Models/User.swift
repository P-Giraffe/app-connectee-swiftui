//
//  User.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 26/05/2022.
//

import Foundation

struct User:Decodable {
    let id:UUID
    let first_name:String
    let last_name:String
    let email:String
}
