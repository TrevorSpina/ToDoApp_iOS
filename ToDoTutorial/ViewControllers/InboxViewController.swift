//
//  InboxViewController.swift
//  ToDoTutorial
//
//  Created by Trevor Spina on 7/18/19.
//  Copyright © 2019 TrevorSpina. All rights reserved.
//

import Foundation
import UIKit

class InboxViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let dummyTasks = ["Take shit", "Change motor oil", "Grease stapler"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inboxCell") as! UITableViewCell
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Inbox"
    }
    
}
