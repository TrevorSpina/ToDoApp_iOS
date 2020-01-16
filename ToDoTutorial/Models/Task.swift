//
//  Task.swift
//  ToDoTutorial
//
//  Created by Trevor Spina on 8/2/18.
//  Copyright © 2018 TrevorSpina. All rights reserved.
//

import Foundation

class Task: TaskObject {
    
    init(title: String, description: String, status: String) {
        super.init()
        self.title = title
        self.status = status
        self.description = description
    }
}
