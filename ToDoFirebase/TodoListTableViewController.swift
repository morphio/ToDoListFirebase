//
//  TodoListTableViewController.swift
//  
//
//  Created by Alex on 23.03.17.
//
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TodoListTableViewController: UITableViewController {

    var arrayOfTasks = [Task]()
    var databaseRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        databaseRef = FIRDatabase.database().reference()
        databaseRef.observe(.value, with: { (snapshot) in
            
            var newTasks = [Task]()
            
            for item in snapshot.children{
                
                let newTask = Task(snapshot: item as! FIRDataSnapshot)
                newTasks.insert(newTask, at: 0)
            }
            
            self.arrayOfTasks = newTasks
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }


    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arrayOfTasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        
        cell.taskNameLabel.text = arrayOfTasks[indexPath.row].title
        cell.usernameLabel.text = arrayOfTasks[indexPath.row].username
        cell.taskDescriptionTextView.text = arrayOfTasks[indexPath.row].desc
        cell.colorView.backgroundColor = UIColor(red: arrayOfTasks[indexPath.row].red, green: arrayOfTasks[indexPath.row].green, blue: arrayOfTasks[indexPath.row].blue, alpha: 1.0)
        
        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            arrayOfTasks.remove(at: indexPath.row)
            
            let ref = arrayOfTasks[indexPath.row].reference
            ref?.removeValue()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    


}
