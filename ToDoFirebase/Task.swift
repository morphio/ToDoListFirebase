//
//  Task.swift
//  FireList
//
//  Created by Alex on 17.06.17.
//  Copyright © 2017 Grid. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Task:NSObject {
    
    var title: String!
    var desc: String! // description
    var username: String!
    var color: UIColor
    var reference: FIRDatabaseReference?
    var key: String!
    
    init(title: String, desc: String, username: String, color: UIColor, key: String = "") {
        
        self.title = title
        self.desc = desc
        self.username = username
        self.color = color
        self.key = key
        self.reference = FIRDatabase.database().reference()
        
    }
    
    init(snapshot: FIRDataSnapshot){
        let values = snapshot.value as! [String: Any]
        
        self.title = values["title"] as! String
        self.desc = values["desc"] as! String
        self.username = values["username"] as! String
        self.color = values["color"] as! UIColor
        self.key = values["key"] as! String
        self.reference = snapshot.ref
    }
    
    func stringToAny() -> [String: Any] {
        return ["title" : title, "desc": desc, "username": username, "color": color, "key" : key,  ]
    }
}
