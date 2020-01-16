//
//  CollapsableTableViewController.swift
//  ToDoTutorial
//
//  Created by Trevor Spina on 8/11/18.
//  Copyright © 2018 TrevorSpina. All rights reserved.
//

import Foundation
import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class CollapsableTableViewController: UITableViewController {

    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    
    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView!.tableFooterView = UIView()
        
        tableViewData = [cellData(opened: false, title: "NOW", sectionData: ["Get hair cut", "Mow lawn","Slap knee", "Make terrarium"]),
                         cellData(opened: false, title: "NEXT", sectionData: ["Water plants", "Learn German obscenities",]),
                         cellData(opened: false, title: "LATER", sectionData: ["Watch 6 hours of YouTube craft videos", "Watch paint dry"]),
                         cellData(opened: false, title: "DONE", sectionData: ["Learn how to code", "Train monkey to code instead"]),
                         cellData(opened: false, title: "NO", sectionData: ["Get a job"])]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        } else {
            //Use different cell identifier if needed
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
}
