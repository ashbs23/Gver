//
//  SettingsViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 10/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit
import Firebase
import PINRemoteImage

class SettingsViewController: UIViewController {
    
    let textFieldAlert = TextFieldAlert()
    let imageFileManagement = ImageFileManagement()
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    func updateUI() {
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.clipsToBounds = true
        settingsTableView.tableFooterView = UIView(frame: .zero)
        
        profileImage.pin_updateWithProgress = true
        profileImage.pin_setImage(from: URL.init(string: ProfileManagementFirestore.userInformation.profileImageURL!), placeholderImage: UIImage(named: "Icon"))
        
    }
    
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.SegueNames.settingsToEditProfile, sender: self)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.settingsTableStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReusableTableCells.settingsTableCell, for: indexPath)
        cell.textLabel!.text = K.settingsTableStrings[indexPath.row]
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("Not yet implemented")
        case 1:
            print("Not yet implemented")
        case 2:
            print("Not yet implemented")
        case 3:
            print("Not yet implemented")
        case 4:
            print("Not yet implemented")
        case 5:
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
                break
            }
            
            textFieldAlert.showBasicAlertNoActionWithClosure(on: self, title: "", message: K.AlertStrings.signingOut) {
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: K.StoryboardID.signInViewController) as? SignInViewController {
                    PINRemoteImageManager.shared().cache.removeAllObjects()
                    self.navigationController?.pushViewController(viewController, animated: true)
                    print("Signout was successful")
                }
            }
        default:
            print("This shouldn't happen")
        }
    }
}
