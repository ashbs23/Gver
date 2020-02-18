//
//  ViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 5/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInPageLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: K.SegueNames.alreadySignedIn, sender: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let tfAlert = TextFieldAlert()
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
                if let e = error {
                    tfAlert.showBasicAlert(on: self, title: "Error", message: e.localizedDescription)
                    
                    print("There was some error while logging in")
                } else {
                    print("User logged in successfully")
                    self.performSegue(withIdentifier: K.SegueNames.signInToHome, sender: self)
                }
            }
        }
    }
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignUp", sender: self)
    }
    
    func updateUI() {
        signInButton.layer.cornerRadius = 20
        signInButton.clipsToBounds = true
        
        signInPageLogo.layer.cornerRadius = signInPageLogo.frame.size.width / 2
        signInPageLogo.clipsToBounds = true
    }
}

