//
//  ViewController.swift
//  hotTakes
//
//  Created by Michael Crum on 12/6/20.
//

/**
 Login view
 Todo:
    2. Network code for login
    3. Input validation
*/

import UIKit

class LoginViewController: UIViewController {
    
    var titleLabel:  UILabel!
    var titleFlame: UIImageView!
    var fillerTextTop: UILabel!
    var fillerTextBottom: UILabel!
    var splashImage: UIImageView!
    
    var usernameBox: UIView!
    var usernameLabel: UILabel!
    var usernameTextField: UITextField!
    
    var passwordBox: UIView!
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
    
    var loginButton: UIButton!
    var signupButton: UIButton!
    
    var warningLabel: UILabel!
    
    var containerViewController : ContainerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        titleLabel = UILabel()
        titleLabel.text = "HOT OR COLD?"
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 35)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleFlame = UIImageView()
        titleFlame.image = UIImage(named: "flame")
        titleFlame.contentMode = .scaleAspectFit
        titleFlame.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleFlame)
        
        fillerTextTop = UILabel()
        fillerTextTop.text = "Get ready to smack your forehead after the greatest eureka moment."
        fillerTextTop.font = UIFont(name: "Roboto-Bold", size: 20)
        fillerTextTop.textColor = UIColor(red: 0.925, green: 0.302, blue: 0.341, alpha: 1)
        fillerTextTop.translatesAutoresizingMaskIntoConstraints = false
        fillerTextTop.numberOfLines = 0
        fillerTextTop.lineBreakMode = .byWordWrapping
        view.addSubview(fillerTextTop)
        
        fillerTextBottom = UILabel()
        fillerTextBottom.text = "Welcome back, debater. Please log in to activate."
        fillerTextBottom.font = UIFont(name: "Roboto-Bold", size: 13)
        fillerTextBottom.textColor = .gray
        fillerTextBottom.translatesAutoresizingMaskIntoConstraints = false
        fillerTextBottom.numberOfLines = 0
        fillerTextBottom.lineBreakMode = .byWordWrapping
        view.addSubview(fillerTextBottom)
        
        splashImage = UIImageView()
        let img = UIImage(named: "login_splash")
        splashImage.image = img
        splashImage.backgroundColor = .white
        splashImage.contentMode = .scaleAspectFit
        splashImage.translatesAutoresizingMaskIntoConstraints = false
        splashImage.addAspectRatioConstraint(image: img)
        view.addSubview(splashImage)
        
        usernameBox = UIView()
        usernameBox.layer.borderWidth = 0.5
        usernameBox.layer.borderColor = UIColor.white.cgColor
        
        usernameLabel = UILabel()
        usernameLabel.text = "Hot takes handle"
        usernameLabel.font = UIFont(name: "Roboto-Bold", size: 15)
        usernameLabel.textColor = .white
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameBox.addSubview(usernameLabel)
        
        usernameTextField = UITextField()
        usernameTextField.attributedPlaceholder = NSAttributedString(string:"Enter your username", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.925, green: 0.302, blue: 0.341, alpha: 0.5)])
        usernameTextField.font = UIFont(name: "Roboto-Regular", size: 15)
        usernameTextField.textColor = UIColor(red: 0.925, green: 0.302, blue: 0.341, alpha: 1)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameBox.addSubview(usernameTextField)
        
        usernameBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameBox)
        
        passwordBox = UIView()
        passwordBox.layer.borderWidth = 0.5
        passwordBox.layer.borderColor = UIColor.white.cgColor
        
        passwordLabel = UILabel()
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont(name: "Roboto-Bold", size: 15)
        passwordLabel.textColor = .white
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordBox.addSubview(passwordLabel)
        
        passwordTextField = UITextField()
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Enter your password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.925, green: 0.302, blue: 0.341, alpha: 0.5)])
        passwordTextField.font = UIFont(name: "Roboto-Regular", size: 15)
        passwordTextField.textColor = UIColor(red: 0.925, green: 0.302, blue: 0.341, alpha: 1)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordBox.addSubview(passwordTextField)
        
        passwordBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordBox)
        
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
        loginButton.backgroundColor = UIColor(red: 0.925, green: 0.302, blue: 0.341, alpha: 1)
        loginButton.layer.cornerRadius = 5
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        signupButton = UIButton()
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
        signupButton.layer.borderWidth = 0.5
        signupButton.layer.borderColor = UIColor.white.cgColor
        signupButton.layer.cornerRadius = 5
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        view.addSubview(signupButton)
        
        warningLabel = UILabel()
        warningLabel.text = "Fill in your password and username before continuing."
        warningLabel.font = UIFont(name: "Roboto-Bold", size: 15)
        warningLabel.textColor = UIColor(red: 0.925, green: 0.302, blue: 0.341, alpha: 1)
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        warningLabel.numberOfLines = 0
        warningLabel.lineBreakMode = .byWordWrapping
        warningLabel.isHidden = true
        view.addSubview(warningLabel)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupConstraints()
        
        containerViewController = ContainerViewController()
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleFlame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleFlame.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleFlame.heightAnchor.constraint(equalToConstant: 50),
            titleFlame.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: titleFlame.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleFlame.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            fillerTextTop.topAnchor.constraint(equalTo: titleFlame.bottomAnchor, constant: 40),
            fillerTextTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fillerTextTop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            fillerTextBottom.topAnchor.constraint(equalTo: fillerTextTop.bottomAnchor, constant: 20),
            fillerTextBottom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fillerTextBottom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            splashImage.topAnchor.constraint(equalTo: fillerTextBottom.bottomAnchor, constant: 20),
            splashImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            splashImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            usernameBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            usernameBox.topAnchor.constraint(equalTo: splashImage.bottomAnchor, constant: 20),
            usernameBox.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: usernameBox.leadingAnchor, constant: 15),
            usernameLabel.topAnchor.constraint(equalTo: usernameBox.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.leadingAnchor.constraint(equalTo: usernameBox.leadingAnchor, constant: 15),
            usernameTextField.trailingAnchor.constraint(equalTo: usernameBox.trailingAnchor, constant: -15),
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 2)
        ])
        
        NSLayoutConstraint.activate([
            passwordBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordBox.topAnchor.constraint(equalTo: usernameBox.bottomAnchor),
            passwordBox.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            passwordLabel.leadingAnchor.constraint(equalTo: passwordBox.leadingAnchor, constant: 15),
            passwordLabel.topAnchor.constraint(equalTo: passwordBox.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: passwordBox.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordBox.trailingAnchor, constant: -15),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 2)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.topAnchor.constraint(equalTo: passwordBox.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            signupButton.leadingAnchor.constraint(equalTo: loginButton.trailingAnchor, constant: 15),
            signupButton.widthAnchor.constraint(equalToConstant: 150),
            signupButton.topAnchor.constraint(equalTo: passwordBox.bottomAnchor, constant: 20),
            signupButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            warningLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func loginButtonTapped(){
        if usernameTextField.text != "" && passwordTextField.text != "" {
            self.showWarning(message: "Loading...")
            NetworkManager.loginUser(username: usernameTextField.text!, password: passwordTextField.text!) { loginResponse in
                if loginResponse.success ?? false == true {
                    CurrentUserData.session_token = loginResponse.session_token
                    CurrentUserData.session_expiration = loginResponse.session_expiration
                    CurrentUserData.update_token = loginResponse.update_token
                    CurrentUserData.username = self.usernameTextField.text!
                    CurrentUserData.userId = loginResponse.id!
                    self.showWarning(message: "Welcome")
                    
                    self.navigationController?.pushViewController(self.containerViewController, animated: true)
                }else if loginResponse.success ?? true == false {
                    self.showWarning(message: loginResponse.error!)
                }else{
                    self.showWarning(message: "Something went wrong. Try again.")
                }
            }
        }else{
            self.showWarning(message: "Fill in your password and username before continuing.")
        }
    }
    
    @objc func signupButtonTapped(){
        if usernameTextField.text != "" && passwordTextField.text != "" {
            self.showWarning(message: "Loading...")
            NetworkManager.signUpUser(username: usernameTextField.text!, password: passwordTextField.text!) { signupResponse in
                if signupResponse.success ?? false == true {
                    CurrentUserData.session_token = signupResponse.session_token
                    CurrentUserData.session_expiration = signupResponse.session_expiration
                    CurrentUserData.update_token = signupResponse.update_token
                    CurrentUserData.username = self.usernameTextField.text!
                    CurrentUserData.userId = signupResponse.id!
                    self.showWarning(message: "Welcome")
                    self.navigationController?.pushViewController(self.containerViewController, animated: true)
                }else if signupResponse.success ?? true == false {
                    self.showWarning(message: signupResponse.error!)
                }else{
                    self.showWarning(message: "Something went wrong. Try again.")
                }
            }
        }else{
            self.showWarning(message: "Fill in your password and username before continuing.")
        }
    }
    
    func showWarning(message: String){
        warningLabel.isHidden = false
        warningLabel.text = message
    }

}

extension UIImageView {
    
    func addAspectRatioConstraint(image: UIImage?) {
        
        if let image = image {
            removeAspectRatioConstraint()
            let aspectRatio = image.size.width / image.size.height
            let constraint = NSLayoutConstraint(item: self, attribute: .width,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .height,
                                                multiplier: aspectRatio, constant: 0.0)
            addConstraint(constraint)
        }
    }
    
    
    func removeAspectRatioConstraint() {
        for constraint in self.constraints {
            if (constraint.firstItem as? UIImageView) == self,
               (constraint.secondItem as? UIImageView) == self {
                removeConstraint(constraint)
            }
        }
    }
}
