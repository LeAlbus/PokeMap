//
//  FirebaseAuthManager.swift
//  PokeMap
//
//  Created by Pedro Lopes on 01/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAuthManager {
    
    func autenticateUser(email: String, password: String, successHandler: @escaping ()->Void, errorHandler: @escaping ()->Void){
        
        Auth.auth().signIn(withEmail: email, password: password){ (user, error) in
        
            if error != nil {
                errorHandler()
            } else {
                successHandler()
            }
        }
    }
    
    func registerUser(email: String, password: String, successHandler: @escaping ()->Void, errorHandler: @escaping ()->Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if error != nil {
                errorHandler()
            } else {
                successHandler()
            }
        }
    }
}
