//
//  User.swift
//  chatapp
//
//  Created by tobioka on 2023/12/22.
//

import Foundation

struct User: Decodable {
    let id: String
    let name: String
    let image: String
    
    var isCurrentUser: Bool {
        self.id == User.currentUser.id
    }
    
    static var currentUser: User{
        User(id:"1", name:"ken", image:"user01")
    }
}
