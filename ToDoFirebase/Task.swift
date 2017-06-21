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

struct Task {
    
    var title: String!
    var desc: String! // description
    var username: String!
    var red: CGFloat
    var blue: CGFloat
    var green: CGFloat
    var reference: FIRDatabaseReference?
    var key: String!
    
    init(title: String, desc: String, username: String, red: CGFloat, blue: CGFloat, green: CGFloat, key: String = "") {
        
        self.title = title
        self.desc = desc
        self.username = username
        self.red = red
        self.blue = blue
        self.green = green
        self.key = key
        self.reference = FIRDatabase.database().reference()
        
    }
    
    init(snapshot: FIRDataSnapshot){
        let values = snapshot.value as! [String: AnyObject]

        self.key = snapshot.key
        self.reference = snapshot.ref
        self.title = (snapshot.value! as! NSDictionary)["title"] as? String
        self.desc = (snapshot.value! as! NSDictionary)["desc"] as? String
        self.username = (snapshot.value! as! NSDictionary)["username"] as? String
        self.red = values["red"] as! CGFloat
        self.blue = values["blue"] as! CGFloat
        self.green = values["green"] as! CGFloat

    }
    
    func toAnyObject() -> [String: AnyObject] {
        return ["title" : title as AnyObject, "desc": desc as AnyObject, "username": username as AnyObject, "red": red as AnyObject, "blue": blue as AnyObject, "green": green as AnyObject, "key" : key as AnyObject]
    }
}
