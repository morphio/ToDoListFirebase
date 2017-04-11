//
//  LoginViewController.swift
//  ToDoFirebase
//
//  Created by Alex on 23.03.17.
//  Copyright © 2017 Grid. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    let server = Server()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func unwindToLogIn(storyboard: UIStoryboardSegue){
        
    }

    @IBAction func logInAction(_ sender: Any) {
        server.signIn(email: emailTextField.text!, password: passwordTextField.text!)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TodoList")
        present(vc, animated: true, completion: nil)
        
        
    }
}
