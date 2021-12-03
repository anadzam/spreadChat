//
//  LoginViewController.swift
//  spreadChat
//
//  Created by Ana Dzamelashvili on 11/20/21.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    //navigate to the chatViewController
                    self.performSegue(withIdentifier: Con.loginSegue, sender: self)
                }
                
            }
        }
        
        
    }
    
}
