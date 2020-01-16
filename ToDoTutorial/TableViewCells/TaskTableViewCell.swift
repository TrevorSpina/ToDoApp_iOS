//
//  TaskTableViewCell.swift
//  ToDoTutorial
//
//  Created by Trevor Spina on 8/2/18.
//  Copyright © 2018 TrevorSpina. All rights reserved.
//

import Foundation
import UIKit

class TaskTableViewCell: UITableViewCell {
    

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var cellSideColor: UIView!
    @IBOutlet weak var cellDescription: UILabel!
    
    
    func configureWith(task: String, description: String, color: UIColor) {
        taskTitle.text = task
        cellDescription.text = description
        cellSideColor.backgroundColor = color
    }
}
