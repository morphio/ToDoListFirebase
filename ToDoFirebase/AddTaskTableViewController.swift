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
    
    var databaseRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveAction(_ sender: Any) {
        // создание ссылки на задачу
        let taskRef = databaseRef.child("AllTasks").childByAutoId()
        
        var title: String!
        if taskTextField.text == ""{
            taskTextField.text = "No task name"
            title = taskTextField.text
        }else{
            title = taskTextField.text

        }
        
        let description:String!
        
        if descriptionTextView.text == ""{
            descriptionTextView.text = "No description of this task"
            description = descriptionTextView.text
        }else{
            description = descriptionTextView.text
        }
        
        let red = CGFloat(arc4random_uniform(UInt32(225.5)))/255.5
        let blue = CGFloat(arc4random_uniform(UInt32(225.5)))/255.5
        let green = CGFloat(arc4random_uniform(UInt32(225.5)))/255.5
        
        
        let task = Task(title: title, desc: description, username: FIRAuth.auth()!.currentUser!.displayName!, red: red, blue: blue, green: green)
        
        taskRef.setValue(task.toAnyObject())
        
    }
    
}
