//
//  TaskCreatorViewController.swift
//  ToDoTutorial
//
//  Created by Trevor Spina on 8/4/18.
//  Copyright © 2018 TrevorSpina. All rights reserved.
//

import Foundation
import UIKit

class TaskCreatorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var taskTitle = ""
    var taskDescription = ""
    var taskStatus = 0
    // each section has an add task button. Section in picker should match
    var originalSectionNumber = 0
    
    var taskArray = [[Task]]()
    
    private let sections = ["NOW", "NEXT", "LATER", "DONE", "NO"]
    
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var taskStatusPickerView: UIPickerView!
    @IBOutlet weak var createTaskButton: UIButton!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createTaskButtonTapped(_ sender: Any) {
        print("Task: \(taskTitleTextField.text ?? "Task")")
        print("Description: \(String(describing: taskDescriptionTextView.text))")
        print("Status: \(taskStatusPickerView.selectedRow(inComponent: 0))")
        if(taskTitleTextField.text != ""){
            performSegue(withIdentifier: "toTaskListView", sender: self)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        taskStatusPickerView.dataSource = self
        taskStatusPickerView.delegate = self
        createTaskButton.isEnabled = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare for segue")
        if(segue.destination is TaskListViewController){
            let vc = segue.destination as? TaskListViewController
            taskStatus = taskStatusPickerView.selectedRow(inComponent: 0)
            vc?.addNewTask(status: Int(taskStatus), task: Task(title: taskTitle, description: taskDescription, status: sections[taskStatus]))
            //vc?.updateTaskArray(array: taskArray)
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskTitleTextField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        print("done editing title")
        taskTitle = taskTitleTextField.text!
        print("Task: \(taskTitleTextField.text ?? "Task")")
        print(taskTitle)
        if(taskTitle != ""){
            createTaskButton.isEnabled = true
            print("button enabled")
        }
    }
    
    private func configureTextFields() {
        taskTitleTextField.delegate = self
    }
}
