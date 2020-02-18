//
//  EditProfileViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 10/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileImageEditButton: UIButton!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var changeAddressButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var imagePicker: ImagePicker!
    let imageFileManagement = ImageFileManagement()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        addressTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self, fileName: K.UserImageDirs.userProfileImage)
        self.title = K.ViewTitle.editProfile
        
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    @IBAction func addressTextFieldTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: K.SegueNames.editProfileToMap, sender: self)
    }
}

extension EditProfileViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        if let img = image {
            self.profileImageView.image = img
        }
    }
}

