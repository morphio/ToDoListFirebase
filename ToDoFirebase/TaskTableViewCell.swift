//
//  TaskTableViewCell.swift
//  FireList
//
//  Created by Alex on 18.06.17.
//  Copyright © 2017 Grid. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        colorView.layer.cornerRadius = 10;
    }


}
