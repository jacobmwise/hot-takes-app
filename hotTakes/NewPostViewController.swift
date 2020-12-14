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
    var bodyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        titleLabel = UILabel()
        titleLabel.text = "New Post Page"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        bodyLabel = UILabel()
        bodyLabel.text = "Complete new post page in this view controller"
        bodyLabel.font = UIFont.boldSystemFont(ofSize: 15)
        bodyLabel.textColor = .white
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bodyLabel)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }
}
