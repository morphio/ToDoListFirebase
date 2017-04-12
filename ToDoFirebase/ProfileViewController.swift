//
//  ProfileViewController.swift
//  FireList
//
//  Created by Alex on 11.04.17.
//  Copyright © 2017 Grid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImageView: ProfileImageView!
    @IBOutlet weak var username: CustomTextField!
    @IBOutlet weak var email: CustomTextField!
    @IBOutlet weak var country: CustomTextField!
    @IBOutlet weak var password: CustomTextField!
    var urlImage: String!
    
    var databaseRef: FIRDatabaseReference{
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorage{
        return FIRStorage.storage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if FIRAuth.auth()?.currentUser == nil {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogIn")
            present(vc, animated: true, completion: nil)
            
        }else{
            databaseRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)").observe(.value, with: { (snapshot) in
                
                let queue = DispatchQueue.main
                queue.async {
                    
                    let user = User(snapshot: snapshot)
                    self.username.text! = user.username
                    self.email.text! = user.email
                    self.country.text! = user.country

                    let imageURL = "https://firebasestorage.googleapis.com" +  (user.photoUrl)
                    
                    self.storageRef.reference(forURL: imageURL).data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) in
                        
                        if let error = error{
                            print(error.localizedDescription)
                        }else{
                            if let data = data {
                                self.userImageView.image = UIImage(data: data)
                            }
                        }
                    })
                }
            }, withCancel: { (error) in
                print(error.localizedDescription)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOutAction(_ sender: Any) {
    
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogIn")
                present(vc, animated: true, completion: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
