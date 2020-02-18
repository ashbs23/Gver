//
//  HomeViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 9/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let profileManagementFirestore = ProfileManagementFirestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        profileManagementFirestore.loadProfileFromFirebase()
        K.UserImageDirs.userProfileImage = "Profile\(Auth.auth().currentUser!.uid).png"
    }
}
