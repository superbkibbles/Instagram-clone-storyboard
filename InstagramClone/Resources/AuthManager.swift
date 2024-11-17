//
//  AuthManager.swift
//  InstagramClone
//
//  Created by Mend Mzury on 11/15/24.
//

import FirebaseAuth

public class AuthManager  {
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String) {
        
    }
    
    public func loginUser(username: String?,email: String?, password: String, completion: @escaping ((Bool) -> Void)) {
        if let email = email {
            // email login
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
                
            }
        } else if let username = username {
            print(username)
            // username login
        }
    }
}

