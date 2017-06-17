//
//  AddTaskViewController.swift
//  ToDoFirebase
//
//  Created by Alex on 23.03.17.
//  Copyright © 2017 Grid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddTaskTableViewController: UITableViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveAction(_ sender: Any) {
    }
}
