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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        titleLabel = UILabel()
        titleLabel.text = "New Post"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }
}
