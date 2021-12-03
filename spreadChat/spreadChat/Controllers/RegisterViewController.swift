//
//  RegisterViewController.swift
//  spreadChat
//
//  Created by Ana Dzamelashvili on 1/20/21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

   
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerPressed(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    //navigate to the chatViewController
                    self.performSegue(withIdentifier: Con.registerSegue, sender: self)
                }
            }
        }
        
        
    }
    
    
}


