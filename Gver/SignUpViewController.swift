//
//  SignUpViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 5/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpPageLogo: UIImageView!
    
    var textField = UITextField()
    let errorMessage = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        signUpButton.layer.cornerRadius = 20
        signUpButton.clipsToBounds = true
        
        emailTextField.layer.borderColor = UIColor.init(named: "AppFocusedTextColor")?.cgColor
        emailTextField.layer.borderWidth = 2.0
        emailTextField.layer.cornerRadius = 10
        emailTextField.clipsToBounds = true
        
        passwordTextField.layer.borderColor = UIColor.init(named: "AppFocusedTextColor")?.cgColor
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.clipsToBounds = true
        
        confirmPasswordTextField.layer.borderColor = UIColor.init(named: "AppFocusedTextColor")?.cgColor
        confirmPasswordTextField.layer.borderWidth = 2.0
        confirmPasswordTextField.layer.cornerRadius = 10
        confirmPasswordTextField.clipsToBounds = true
        
        signUpPageLogo.layer.cornerRadius = signUpPageLogo.frame.size.width / 2
        signUpPageLogo.clipsToBounds = true
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let tfAlert = TextFieldAlert()
        if let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text {
            
            if (password == confirmPassword) {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        tfAlert.showBasicAlert(on: self, title: "Error", message: e.localizedDescription)
                        
                        print("There was some error to register the user")
                        
                    } else {
                        K.db.collection(K.FStoreFields.UserInformationFields.userInformationCollectionName).document((authResult?.user.uid)!)
                        tfAlert.showBasicAlertNoActionWithPerformSegue(on: self, title: "Confirmation", message: K.AlertStrings.registrationSuccessfulMsg, segueName: K.SegueNames.signUpToHome)
                        
                        print("User registered successfully")
                        
                        DispatchQueue.main.async {
                            self.emailTextField.text = ""
                            self.passwordTextField.text = ""
                            self.confirmPasswordTextField.text = ""
                        }
                    }
                }
            } else if password != confirmPassword {
                tfAlert.showBasicAlert(on: self, title: "Error", message: K.AlertStrings.confirmPasswordError)
            }
        }
    }
    
}
