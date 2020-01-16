//
//  SectionHeader.swift
//  ToDoTutorial
//
//  Created by Trevor Spina on 1/9/19.
//  Copyright © 2019 TrevorSpina. All rights reserved.
//

import Foundation
import UIKit

class SectionHeader: TaskObject {
    
    init(sectionTitle: String, sectionNumber: Int, taskCount: String){
        super.init()
        title = sectionTitle
        count = taskCount
    }
    
}
