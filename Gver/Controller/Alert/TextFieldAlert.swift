//
//  AlertController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 14/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import UIKit

struct TextFieldAlert {
    
    func showBasicAlert(on viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            viewController.present(alertController, animated: true)
        }
    }
    
    func showBasicAlertNoActionWithPerformSegue(on viewController: UIViewController, title: String, message: String, segueName: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            viewController.present(alertController, animated: true) {
                alertController.dismiss(animated: true, completion: nil)
                viewController.performSegue(withIdentifier: segueName, sender: viewController)
            }
        }
    }
    
    func showBasicAlertNoActionWithClosure(on viewController: UIViewController, title: String, message: String, handler: (() -> Void)?) {
        let alertControllerSuccessful = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        
        viewController.present(alertControllerSuccessful, animated: true) {
            alertControllerSuccessful.dismiss(animated: true, completion: handler)
        }
    }
}
