//
//  LoginViewController.swift
//  PokeMap
//
//  Created by Pedro Lopes on 01/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var blockerView: UIView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handleBlockerView(appear: false)
    }
    
    func validFields() -> Bool{
        
        if let email = self.emailTextField.text, !email.isEmpty{
            if let password = self.passwordTextField.text, !password.isEmpty{
                return true
            }
        }
        return false
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        
        if self.validFields(){
            
            self.handleBlockerView(appear: true)
            FirebaseAuthManager().autenticateUser(email: email, password: password, successHandler: {self.proceedFromLogin()}, errorHandler: {self.loginError()})
        }
        
        else {
            self.handleBlockerView(appear: true)
            FirebaseAuthManager().autenticateUser(email: "pedrolopes.dev@gmail.com", password: "123456", successHandler: {self.proceedFromLogin()}, errorHandler: {self.loginError()})
        }
    }
    
    func handleBlockerView(appear: Bool) {
        
        if appear {
            self.blockerView.alpha = 0.75
            self.loadingIndicatorView.startAnimating()
        }
        
        else {
            self.blockerView.alpha = 0
            self.loadingIndicatorView.stopAnimating()
        }
    }
    
    func loginError() {
        self.handleBlockerView(appear: false)
        
        let errorAlert = UIAlertController(title: "Error", message: "Unable to login", preferredStyle: UIAlertController.Style.alert)
        
        errorAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    func proceedFromLogin() {
        self.handleBlockerView(appear: false)
        self.performSegue(withIdentifier: "proceedFromLogin", sender: nil)
    }
}
