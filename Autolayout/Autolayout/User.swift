//
//  User.swift
//  Autolayout
//
//  Created by DP on 16/4/4.
//  Copyright © 2016年 DP. All rights reserved.
//

import Foundation
struct User {
    let name:String
    let company:String
    let login:String
    let password:String
    
    static func login(login:String, password:String) -> User?{
        if let user = database[login]{
            if user.password == password{
                return user
            }
        }
        return nil
    }
    
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name:"bat0", company:"WayneTech1",login:"bat1",password:"bat"),
            User(name:"bat1", company:"WayneTech2",login:"bat2",password:"bat"),
            User(name:"bat2", company:"WayneTech3",login:"bat3",password:"bat")
            ]
        {
                theDatabase[user.login] = user
        }
        return theDatabase
    }()
    
}