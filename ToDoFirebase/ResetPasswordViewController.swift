//
//  ResetPasswordViewController.swift
//  ToDoFirebase
//
//  Created by Alex on 23.03.17.
//  Copyright © 2017 Grid. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: CustomTextField!
    let server = Server()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetPasswordAction(_ sender: Any) {
        server.resetPassword(email: emailTextField.text!)
    }
}
