//
//  Todo.swift
//  FireList
//
//  Created by Alex on 13.06.17.
//  Copyright © 2017 Grid. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Todo{
    
    var title: String!
    var content: String!
    var username: String!
    var red: CGFloat!
    var blue: CGFloat!
    var green: CGFloat!
    var ref: FIRDatabaseReference?
    var key: String!
    
    
    init(title: String, content: String, username: String, red: CGFloat, blue: CGFloat, green:CGFloat, key: String = "") {
        
        self.title = title
        self.content = content
        self.username = username
        self.red = red
        self.blue = blue
        self.green = green
        self.key = key
        self.ref = FIRDatabase.database().reference()
    }
    init(snapshot: FIRDataSnapshot){
        
        let values = snapshot.value as! [String: Any]
        
        self.title = values["title"] as! String
        self.content = values["content"] as! String
        self.username = values["username"] as! String
        self.red = values["red"] as! CGFloat
        self.blue = values["bleu"] as! CGFloat
        self.green = values["green"] as! CGFloat
        self.key = snapshot.key
        self.ref = snapshot.ref
        
    }
}
