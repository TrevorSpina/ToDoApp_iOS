//
//  TestTableView.swift
//  ToDoTutorial
//
//  Created by Trevor Spina on 1/3/19.
//  Copyright © 2019 TrevorSpina. All rights reserved.

import Foundation
import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let NUMBER_OF_SECTIONS = 5
    var currentSection = 0
    let sectionColors = [#colorLiteral(red: 0.2235294118, green: 0.6862745098, blue: 0.7803921569, alpha: 1), #colorLiteral(red: 0.3019607843, green: 0.4431372549, blue: 0.7882352941, alpha: 1), #colorLiteral(red: 0.9882352941, green: 0.6196078431, blue: 0.2235294118, alpha: 1), #colorLiteral(red: 0.4352941176, green: 0.737254902, blue: 0.0431372549, alpha: 1), #colorLiteral(red: 0.9058823529, green: 0.3058823529, blue: 0.1411764706, alpha: 1)]
    
    @IBAction func addNewTaskButtonTapped(_ sender: Any) {
        
    }
    @IBOutlet weak var taskTableView: UITableView!
    
    // array of Task arrays containing the tasks for each section (5 arrays)
    private var taskArray = [[Task]]()
    // array containing the information for each cell displayed in the UITableView. task and header cells
    private var cellArray = [TaskObject]()
    // names of each section
    private let sections = ["NOW", "NEXT", "LATER", "DONE", "NO"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add five empty Task arrays, one for each status
        while(taskArray.count < NUMBER_OF_SECTIONS) {
            taskArray.append([Task]())
        }
        print("updating record 3...")
        guard let tasksURL = URL(string: "https://todo.thespinas.com/api/update_test.php") else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: tasksURL) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let taskStruct =  try JSONDecoder().decode(Array<TaskStruct>.self, from: data)
                    print(taskStruct)
                    print(data)
                }catch{
                    print(error)
                }
            }
        }.resume()
        
        loadTasksOld()
        taskTableView?.delegate = self
        taskTableView?.dataSource = self
        taskTableView?.isEditing = true
        navigationItem.title = "By status"
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if(cellArray[indexPath.row] is Task){
            return true
        } else if(cellArray[indexPath.row] is SectionHeader){
            return false
        }else{
            fatalError("Found cell that is not task or section header")
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveTask(indexFrom: sourceIndexPath.row, indexTo: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func addNewTask(status: Int, task: Task) {
        while(taskArray.count < NUMBER_OF_SECTIONS) {
            taskArray.append([Task]())
        }
        taskArray[status].append(task)
    }
    // moves task to a different location in taskArray and recreates cellArray
    // indexFrom - the current index of the task in cellArray
    // sectionTo - the section the task will be moved to ex. NOW, NEXT, etc
    // indexTo - the index the task will be moved to within cellArray NOT taskArray
    func moveTask(indexFrom: Int, indexTo: Int){
        // task can not be moved before "NOW" section
        var adjustedIndexTo = indexTo
        if(indexTo == 0){
            adjustedIndexTo = 1
        }
        let sourceSection = getTaskArrayLocation(cellArrayIndex: indexFrom)[0]
        let sourceIndex = getTaskArrayLocation(cellArrayIndex: indexFrom)[1]
        let destinationSection = getTaskArrayLocation(cellArrayIndex: adjustedIndexTo)[0]
        var destinationIndex = getTaskArrayLocation(cellArrayIndex: adjustedIndexTo)[1]
        if(sourceIndex < destinationIndex && sourceSection < destinationSection){
            destinationIndex += 1
        }
        if(cellArray[adjustedIndexTo] is SectionHeader){
            if(taskArray[destinationSection].count == 0){
                if(destinationSection > sourceSection){
                    taskArray[destinationSection].append(taskArray[sourceSection].remove(at: sourceIndex))
                }else if(destinationSection > 0){
                    taskArray[destinationSection - 1].append(taskArray[sourceSection].remove(at: sourceIndex))
                }
            }else{
                if(destinationIndex < 0){
                    destinationIndex = 0
                }
                if(destinationSection > sourceSection){
                    taskArray[destinationSection].insert(taskArray[sourceSection].remove(at: sourceIndex), at: destinationIndex)
                }else if(destinationSection > 0){
                    taskArray[destinationSection - 1].insert(taskArray[sourceSection].remove(at: sourceIndex), at: destinationIndex)
                }
            }
        }else{
            if(destinationSection > sourceSection){
                destinationIndex += 1
            }
            if(destinationIndex >= taskArray[destinationSection].count){
                taskArray[destinationSection].append(taskArray[sourceSection].remove(at: sourceIndex))
            }else{
                taskArray[destinationSection].insert(taskArray[sourceSection].remove(at: sourceIndex) , at: destinationIndex)
            }
        }
        createCellArray()
        self.taskTableView.reloadData()
    }
    
    func getCellArrayIndex(section: Int, taskArrayIndex: Int) -> Int {
        switch(section){
        case 0:
            return taskArrayIndex + 1
        case 1:
            return taskArray[0].count + taskArrayIndex + 2
        case 2:
            return taskArray[0].count + taskArray[1].count + taskArrayIndex + 3
        case 3:
            return taskArray[0].count + taskArray[1].count + taskArray[2].count + taskArrayIndex + 4
        case 4:
            return taskArray[0].count + taskArray[1].count + taskArray[2].count + taskArray[3].count + taskArrayIndex + 5
        default:
            return 1
        }
    }
    // returns the location of a task in the task array based on a given cell array index as an array [section, index]
    func getTaskArrayLocation(cellArrayIndex: Int) -> [Int] {
        var taskArrayIndex = cellArrayIndex
        var section = 0
        // count number of section headers before given index
        for i in 0...cellArrayIndex {
            if(cellArray[i] is SectionHeader){
                section += 1
            }
        }
        //print("\(cellArray[cellArrayIndex].title) - \(section)")
        // section index is one less than the number of sections
        section -= 1
        if(section > 0){
            for i in 0...section - 1{
                taskArrayIndex -= taskArray[i].count + 1
            }
            
        // index is in "NOW" section
        }
        //print("cellArray: \(cellArrayIndex)")
        //print("taskArray: \(taskArrayIndex)")
        return [section, taskArrayIndex - 1]
    }
    // creates array containing all cells that are actually displayed
    func createCellArray() {
        cellArray.removeAll()
        for section in 0...taskArray.count - 1{
            var newTaskObject: TaskObject
            newTaskObject = SectionHeader(sectionTitle: sections[section], sectionNumber: section, taskCount: "\(taskArray[section].count)")
            cellArray.append(newTaskObject)
            if(taskArray[section].count > 0){
                for row in 0...taskArray[section].count - 1 {
                    newTaskObject = taskArray[section][row]
                    cellArray.append(newTaskObject)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(cellArray.count > indexPath.row && cellArray.count != 0){
            if(cellArray[indexPath.row] is SectionHeader){
                let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCellReuseIdentifier") as! SectionViewCell
                cell.configureWith(title: cellArray[indexPath.row].title, taskCount: cellArray[indexPath.row].count, color: sectionColors[getTaskArrayLocation(cellArrayIndex: indexPath.row)[0]])
                return cell
            }else if(cellArray[indexPath.row] is Task){
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! TaskTableViewCell
                cell.configureWith(task: cellArray[indexPath.row].title, description: cellArray[indexPath.row].description, color: sectionColors[getTaskArrayLocation(cellArrayIndex: indexPath.row)[0]])
                return cell
            }else{
                fatalError("ERROR: cell type in cellArray not recognized")
            }
        }
        return tableView.dequeueReusableCell(withIdentifier: "sectionCellReuseIdentifier") as! SectionViewCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare for segue")
        if(segue.destination is TaskCreatorViewController){
            let vc = segue.destination as? TaskCreatorViewController
            vc?.taskArray = self.taskArray
        }
    }
    
    struct TaskStruct: Decodable {
        var TaskName: String
        var StatusName: String
        var Description: String
    }
    
    
    enum CodingKeys : String, CodingKey {
        case TaskName
        case Description
    }
    
    func getStatusId(statusName: String) -> Int{
        switch(statusName){
        case "Inbox":
            return 0
        case "Now":
            return 0
        case "Next":
            return 1
        case "Later":
            return 2
        case "Done":
            return 3
        case "No":
            return 4
        default:
            return 0
        }
    }
    
    func loadTasksOld() {
        
        print("loading tasks...")
        guard let tasksURL = URL(string: "https://todo.thespinas.com/api/usertasks_get.php") else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: tasksURL) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    // decode JSON data
                    let taskStruct =  try JSONDecoder().decode(Array<TaskStruct>.self, from: data)
                    print(taskStruct)
                    for taskIndex in 0...taskStruct.count - 1 {
                        // append new task to task array
                        let newTask = Task(title: taskStruct[taskIndex].TaskName, description: taskStruct[taskIndex].Description, status: taskStruct[taskIndex].StatusName)
                        let newTaskStatus = self.getStatusId(statusName: taskStruct[taskIndex].StatusName)
                        self.taskArray[newTaskStatus].append(newTask)
                    }
//                    let plain = "15"
//                    let timeInterval = Int(Date().timeIntervalSince1970)
//                    let timeIntervalString = "\(timeInterval)"
//                    let saltedPlain = plain + timeIntervalString
//                    let hashed = saltedPlain.sha256()
                    //                    print("plain text: \(plain)")
                    //                    print("time interval: \(timeInterval)")
                    //                    print("salted plain text: \(saltedPlain)")
                    //                    print("–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-––––––––––")
                    //                    print("Hashed Key: \(hashed)")
                    //                    print("––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––")
                    self.createCellArray()
                    
                } catch {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self.taskTableView?.reloadData()
               
            }
            }.resume()
    }
    
    func loadTasks() {
        let domain = "https://todo.thespinas.com"
        let fileAddress = "/api/api-tasklist-status.php"
        let request = "?PersonID=1&StatusID=1"
        
        print("loading tasks...")
        guard let tasksURL = URL(string: "\(domain)\(fileAddress)\(request)") else {
            return
        }
        print("getting \(domain)\(fileAddress)\(request)")
        let session = URLSession.shared
        session.dataTask(with: tasksURL) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    // decode JSON data
                    let taskStruct =  try JSONDecoder().decode(Array<TaskStruct>.self, from: data)
                    print("(---")
                    print(data)
                    print("---)")
                    print("task struct")
                    print(taskStruct)
                    for taskIndex in 0...taskStruct.count - 1 {
                        // append new task to task array
                        let newTask = Task(title: taskStruct[taskIndex].TaskName, description: "", status: "NOW")
                        //self.taskArray.append(newTask)
                        print("\(taskStruct[taskIndex].TaskName) added")
                        print("time: \(newTask.status)")
                        switch(newTask.status){
                        case self.sections[0]:
                            self.taskArray[0].append(newTask)
                        case self.sections[1]:
                            self.taskArray[1].append(newTask)
                        case self.sections[2]:
                            self.taskArray[2].append(newTask)
                        case self.sections[3]:
                            self.taskArray[3].append(newTask)
                        case self.sections[4]:
                            self.taskArray[4].append(newTask)
                        default:
                            print("ERROR: section number not valid")
                        }
                    }
//                    let plain = "15"
//                    let timeInterval = Int(Date().timeIntervalSince1970)
//                    let timeIntervalString = "\(timeInterval)"
//                    let saltedPlain = plain + timeIntervalString
//                    let hashed = saltedPlain.sha256()
                    //                    print("plain text: \(plain)")
                    //                    print("time interval: \(timeInterval)")
                    //                    print("salted plain text: \(saltedPlain)")
                    //                    print("–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-––––––––––")
                    //                    print("Hashed Key: \(hashed)")
                    //                    print("––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––")
                    //
                } catch {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self.taskTableView.reloadData()
            }
            }.resume()
    }
    
    func postTest() {
        
        guard let url = URL(string: "https://todo.thespinas.com/api/posttest.php") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        print("httpbody:")
        request.httpBody = "Test=testValue".data(using: .utf8)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error)  in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    print("data",String(decoding: data, as: UTF8.self))
                }
            }.resume()
    }
    
    func printStuff() {
        print("Tasks Loaded:")
        for task in 0...taskArray.count - 1{
            print(taskArray[task])
        }
    }
}
