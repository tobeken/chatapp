//
//  Message.swift
//  chatapp
//
//  Created by tobioka on 2023/12/22.
//

import Foundation

struct Message: Decodable, Identifiable {
    let id:String
    let text:String
    let user: User
    let date:String
    let readed: Bool
    
}
