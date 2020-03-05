//
//  ProfileViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 10/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let profileOptions = [
        "Notification Settings",
        "About",
        "Rate this app",
        "Contact us",
        "Share with friends",
        "Signout"
    ]

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        editProfileButton.layer.cornerRadius = 20
        editProfileButton.clipsToBounds = true
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = profileOptions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: option, for: indexPath)
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = .byWordWrapping
        cell.textLabel!.text = profileOptions[indexPath.row]

        return cell
    }
}
