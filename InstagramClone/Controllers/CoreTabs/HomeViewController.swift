//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Mend Mzury on 11/14/24.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        // Check auth status
        if Auth.auth().currentUser == nil {
            // Show Login
            let LoginVC = LoginViewController()
            LoginVC.modalPresentationStyle = .fullScreen
            present(LoginVC, animated: false, completion: nil)
        }
    }


}

