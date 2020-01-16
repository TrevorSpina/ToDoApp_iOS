//
//  TaskObject.swift
//  ToDoTutorial
//
//  Created by Trevor Spina on 1/9/19.
//  Copyright © 2019 TrevorSpina. All rights reserved.
//

import Foundation
import UIKit

class TaskObject {
    
    var title: String
    var description: String
    var count: String
    var status: String
    var sectionNumber: Int
    
    init(){
        title = ""
        count = ""
        status = ""
        description = ""
        sectionNumber = 0
    }
}
