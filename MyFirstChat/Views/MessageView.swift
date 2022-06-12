//
//  MessageView.swift
//  MyFirstChat
//
//  Created by Johan Guenaoui on 01/06/2022.
//

import SwiftUI

struct MessageView: View {
    @StateObject var messageViewModel:MessageViewModel
    var body: some View {
        List(messageViewModel.messages, id:\.id) { item in
            Text("\(item.user_created.last_name) \(item.user_created.first_name)")
                .bold()
            Text("\(item.Content)")
        }
    }
}
