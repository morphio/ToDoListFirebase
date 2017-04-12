//
//  User.swift
//  FireList
//
//  Created by Alex on 12.04.17.
//  Copyright © 2017 Grid. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class User: NSObject {
    
    //MARK: - Variables
    
    var username: String!
    var email: String!
    var photoUrl: String!
    var country: String!
    var reference: FIRDatabaseReference?
    var key: String
    
    init(snapshot: FIRDataSnapshot) {
        print("\(snapshot)")
        let value = snapshot.value as! [String:AnyObject]
        
        username = value["username"] as! String
        email = value["email"] as! String
        photoUrl = value["photoUrl"] as! String
        country = value["country"] as! String 
        reference = snapshot.ref
        key = snapshot.key
    }
    
}
