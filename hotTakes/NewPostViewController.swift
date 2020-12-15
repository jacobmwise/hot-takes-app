//
//  NewPostViewController.swift
//  hotTakes
//
//  Created by Michael Crum on 12/6/20.
//

/**
 New post view
 Todo:
    1. Add UI elements for new post (text entry, post button, ect.)
    2. Make the post button POST the take to the backend, dismiss new post detail view
 */

import UIKit

class NewPostViewController: UIViewController {
    var titleLabel: UILabel!
    
    var newTakeBox: UIView!
    var newTakeLabel: UILabel!
    var newTakeTextField: UITextView!
    
    var postButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        titleLabel = UILabel()
        titleLabel.text = "New Post"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        newTakeBox = UIView()
        newTakeBox.layer.borderWidth = 0.5
        newTakeBox.layer.borderColor = UIColor.white.cgColor
        
        newTakeLabel = UILabel()
        newTakeLabel.text = "Enter your hottest take:"
        newTakeLabel.font = UIFont(name: "Roboto-Bold", size: 15)
        newTakeLabel.textColor = .white
        newTakeLabel.translatesAutoresizingMaskIntoConstraints = false
        newTakeBox.addSubview(newTakeLabel)
        
        newTakeTextField = UITextView()
        //newTakeTextField.attributedPlaceholder = NSAttributedString(string:"Enter your hottest take", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.925, green: 0.302, blue: 0.341, alpha: 0.5)])
        newTakeTextField.backgroundColor = .black
        newTakeTextField.font = UIFont(name: "Roboto-Regular", size: 20)
        newTakeTextField.textColor = UIColor(red: 0.925, green: 0.302, blue: 0.341, alpha: 1)
        newTakeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        newTakeBox.addSubview(newTakeTextField)
        newTakeBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newTakeBox)
        
        postButton = UIButton()
        postButton.setTitle("Post!", for: .normal)
        postButton.setTitleColor(.white, for: .normal)
        postButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
        postButton.backgroundColor = UIColor(red: 0.925, green: 0.302, blue: 0.341, alpha: 1)
        postButton.layer.cornerRadius = 5
        postButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.addTarget(self, action: #selector(postPressed), for: .touchUpInside)
        view.addSubview(postButton)
        
        setupConstraints()
    }
    
    @objc func postPressed(){
        if(newTakeTextField.text != ""){
            NetworkManager.createTake(text: newTakeTextField.text!, user_id: CurrentUserData.userId){response in
                self.postButton.setTitle("Posted!", for: .normal)
            }
        }
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            postButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            postButton.widthAnchor.constraint(equalToConstant: 150),
            postButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            postButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            newTakeBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newTakeBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            newTakeBox.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            newTakeBox.bottomAnchor.constraint(equalTo: postButton.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            newTakeLabel.leadingAnchor.constraint(equalTo: newTakeBox.leadingAnchor, constant: 15),
            newTakeLabel.topAnchor.constraint(equalTo: newTakeBox.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            newTakeTextField.leadingAnchor.constraint(equalTo: newTakeBox.leadingAnchor, constant: 15),
            newTakeTextField.trailingAnchor.constraint(equalTo: newTakeBox.trailingAnchor, constant: -15),
            newTakeTextField.topAnchor.constraint(equalTo: newTakeLabel.bottomAnchor, constant: 2),
            newTakeTextField.bottomAnchor.constraint(equalTo: newTakeBox.bottomAnchor, constant: -10)
        ])
    }
}
