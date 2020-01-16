//
//  SectionViewCell.swift
//  ToDoTutorial
//
//  Created by Trevor Spina on 1/8/19.
//  Copyright © 2019 TrevorSpina. All rights reserved.
//

import Foundation
import UIKit

class SectionViewCell: UITableViewCell {
    
    
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var cellSideColor: UIView!
    @IBOutlet weak var plusButtonView: UIView!
    
    func configureWith(title: String, taskCount: String, color: UIColor){
        sectionTitle.text = title
        cellSideColor.backgroundColor = color
        if(title == "NOW"){
            plusButtonView.isHidden = false
        }else{
            plusButtonView.isHidden = true
        }
    }
}
