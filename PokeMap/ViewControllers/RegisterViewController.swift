//
//  RegisterViewController.swift
//  PokeMap
//
//  Created by Pedro Lopes on 02/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkEqualPasswords() -> Bool {
        
        let pass = self.passwordTextField.text
        let confirm = self.confirmPasswordTextField.text
        
        if pass == confirm {
            return true
        }
        
        return false
    }
    
    func validFields() -> Bool{
        
        if let email = self.emailTextField.text, !email.isEmpty{
            if let password = self.passwordTextField.text, !password.isEmpty{
                if let confirm = self.confirmPasswordTextField.text, !confirm.isEmpty{
                    return true
                }
            }
        }
        return false
    }
    
    @IBAction func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerAction(_ sender: Any) {
        
        if self.validFields() && self.checkEqualPasswords() {
            
            let email = self.emailTextField.text!
            let pass = self.passwordTextField.text!
            
            FirebaseAuthManager().registerUser(email: email, password: pass, successHandler: {self.endRegister(with: true)}, errorHandler: {self.endRegister(with: false)
            })
        }
    }
    
    func endRegister(with success: Bool) {
       
        var title: String = "Success"
        var message: String = "User successfully created"
        
        if !success{
            title = "Error"
            message = "Unable to create user"
        }
        
        let registrationAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        registrationAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
            
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        
        self.present(registrationAlert, animated: true, completion: nil)
    }
}
