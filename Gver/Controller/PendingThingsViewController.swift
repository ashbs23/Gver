//
//  PendingThingsViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 14/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit

class PendingThingsViewController: UIViewController {
    
    var firstTime = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if firstTime {
            self.tabBarController?.selectedIndex = 2
            firstTime = false
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
