//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Mend Mzury on 11/14/24.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.cornerRadius = Constants.cornerRadius
        
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button =  UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
        loginButton.addTarget(self, action: #selector(didTabLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTabCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTabTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTabPrivacyButton), for: .touchUpInside)
        
        addSubviews()
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frames
        headerView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/3.0)
        
        usernameEmailField.frame = CGRect(x: 25, y: headerView.bottom + 40, width: view.width - 50, height: 52)
        
        passwordField.frame = CGRect(x: 25, y: usernameEmailField.bottom + 10, width: view.width - 50, height: 52)
        
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.width - 50, height: 52)
        
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.width - 50, height: 52)
        
        termsButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 100, width: view.width - 20, height: 50)
        
        privacyButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 50, width: view.width - 20, height: 50)
        
        
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else { return }
        
        guard let backgrounView = headerView.subviews.first else { return }
        
        backgrounView.frame = headerView.bounds
        
        // Add instagram logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4, y: view.safeAreaInsets.top, width: headerView.width/2, height: headerView.height - view.safeAreaInsets.top)
        
        
    }
    
    private func addSubviews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(headerView)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(createAccountButton)
        view.addSubview(privacyButton)
    }
    
    @objc private func didTabLoginButton() {
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else { return }
        
        // Login functionality
        var username: String?
        var email: String?
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            email = usernameEmail
        } else {
            username = usernameEmail
        }
        AuthManager.shared.loginUser(username: username, email: email, password: password) { ok in
            DispatchQueue.main.async {
                if ok {
                    // user login in
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // error
                    let alert = UIAlertController(title: "Log In Error", message: "Invalid username or password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    @objc private func didTabTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else { return }
        let vc = SFSafariViewController(url: url)
        
        present(vc, animated: true , completion: nil)
    }
    @objc private func didTabPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/155833707900388") else { return }
        let vc = SFSafariViewController(url: url)
        
        present(vc, animated: true , completion: nil)
    }
    @objc private func didTabCreateAccountButton() {
        let vc = RegestrationViewController()
        present(vc, animated: true, completion: nil)
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTabLoginButton()
        }
        
        return true
    }
}
