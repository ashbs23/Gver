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
    @IBOutlet weak var showMyLocationButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var imagePicker: ImagePicker!
    let imageFileManagement = ImageFileManagement()
    var locationManagement = LocationManagement.reference
    
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
        addressTextFieldDoubleTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    @objc func doubleTapAction() {
        performSegue(withIdentifier: K.SegueNames.editProfileToMap, sender: self)
    }
    
    func addressTextFieldDoubleTapped() {
        let singleTapGesture = UITapGestureRecognizer(target: self, action: nil)
        singleTapGesture.numberOfTapsRequired = 1
        addressTextField.addGestureRecognizer(singleTapGesture)
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        doubleTapGesture.numberOfTapsRequired = 2
        addressTextField.addGestureRecognizer(doubleTapGesture)
        singleTapGesture.require(toFail: doubleTapGesture)
        
        
    }
    
    @IBAction func showMyLocationButtonPressed(_ sender: UIButton) {
        locationManagement.locationManager.startUpdatingLocation()
        let locationInformation = locationManagement.getLocationInformation()
        print(locationInformation)
        DispatchQueue.main.async {
            self.addressTextField.text = locationInformation["address"] as? String
        }
    }
}

extension EditProfileViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        if let img = image {
            self.profileImageView.image = img
        }
    }
}

