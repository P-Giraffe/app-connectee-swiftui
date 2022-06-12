//
//  Token.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 11/06/2022.
//

import Foundation

struct Token:Decodable {
    var access_token:String
    var expires:Int
    var refresh_token:String
}
