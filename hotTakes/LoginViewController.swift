//
//  ViewController.swift
//  hotTakes
//
//  Created by Michael Crum on 12/6/20.
//

/**
 Login view
 Todo:
    1. Asthetic upgrades (i.e. logo, colors)
    2. Network code for login
    3. Input validation
*/

import UIKit

class LoginViewController: UIViewController {
    
    var titleLabel:  UILabel!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    
    var feedViewController : FeedViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        titleLabel = UILabel()
        titleLabel.text = "Hot Takes"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        usernameTextField = UITextField()
        usernameTextField.placeholder = "Username"
        usernameTextField.font = UIFont.boldSystemFont(ofSize: 24)
        usernameTextField.textColor = .black
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameTextField)
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.boldSystemFont(ofSize: 24)
        passwordTextField.textColor = .black
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.backgroundColor = .red
        loginButton.layer.borderWidth = 3
        loginButton.layer.borderColor = UIColor.red.cgColor
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        signupButton = UIButton()
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        signupButton.backgroundColor = .blue
        signupButton.layer.borderWidth = 3
        signupButton.layer.borderColor = UIColor.blue.cgColor
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        view.addSubview(signupButton)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupConstraints()
        
        feedViewController = FeedViewController()
        
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            usernameTextField.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -5),
            usernameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
            
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
            
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
            
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -15),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            signupButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signupButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signupButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func loginButtonTapped(){
        //INSERT LOGIN CODE
        navigationController?.pushViewController(feedViewController, animated: true)
    }
    
    @objc func signupButtonTapped(){
        //INSERT LOGIN CODE
        navigationController?.pushViewController(feedViewController, animated: true)
    }

}
