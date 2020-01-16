//
//  TabBarNavigationViewController.swift
//  ToDoTutorial
//
//  Created by Trevor Spina on 7/19/19.
//  Copyright © 2019 TrevorSpina. All rights reserved.
//

import Foundation
import UIKit

class TabBarNavigationViewController: UITabBarController {
    
    //let contextVC = TaskListViewController()
    //let inboxVC = InboxViewController()
    //let tabBarVC = UITabBarController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.selectedItem?.badgeColor = #colorLiteral(red: 0.1019607843, green: 0.6078431373, blue: 0.7098039216, alpha: 1)
    }
    
}
