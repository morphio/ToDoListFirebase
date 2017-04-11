//
//  NetworkingService.swift
//  FireList
//
//  Created by Alex on 02.04.17.
//  Copyright © 2017 Grid. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct Server {
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    private func saveUserInfo(user:FIRUser!, username: String, password: String, country: String){
        
        //создание словаря для юзера
        let userInfo = ["email": user.email!, "username":username, "country": country, "uid": user.uid, "photoUrl": String(user.photoURL!.path)]
        //создание ссылки на пользователя
        let userRef = databaseRef.child("users").child(user.uid)
        
        //сохранение юзера в базе данных FB
        userRef.setValue(userInfo)
        
        //sign in
        signIn(email: user.email!, password: password)
    }
    
    func signIn(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user{
                    print("\(user.displayName!), вошел! ")
                }
            }else{
                print(error!.localizedDescription)
            }

        })
    }
    
    private func setUserInfo(user:FIRUser!, username: String, password: String, country: String, data: NSData){
        
        //создание пути на пикчу юзера
        let imagePath = "profileImage\(user.uid)/userPicture.jpg"
        
        //создание ссылки на пикчу юзера
        let imageRef = storageRef.child(imagePath)
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpg"
        
        imageRef.put(data as Data, metadata: metadata) { (metaData, error) in
            if error == nil {
                
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData?.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil{
                        
                        self.saveUserInfo(user: user, username: username, password: password, country: country)
                    }else{
                        print(error!.localizedDescription)
                    }
                })
            }else{
                print(error!.localizedDescription)

            }
        }
        
    }
    
    func signUp(email:String,  username: String, password: String, country: String, data: NSData){
        //создание юзера в FB
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil{
                self.setUserInfo(user: user, username: username, password: password, country: country, data: data)
            }else{
                print(error!.localizedDescription)
            }
        })
    }
    func resetPassword(email: String)  {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil{
                print("reset your password")
            }else{
                print(error!.localizedDescription)
            }
        })
    }
}

