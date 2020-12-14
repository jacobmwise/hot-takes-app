//
//  FeedViewController.swift
//  hotTakes
//
//  Created by Michael Crum on 12/6/20.
//

/**
 Feed view
 Todo:
    1. Add new post button (should present a NewPostViewController as a detail view)
    2. Pull data from backend
    3. Customize the table cells (see TakeTableViewCell for todo)
    4. Make new post page funcitonal (see NewPostViewController for todo)
 */

import UIKit

class FeedViewController: UIViewController {
    var titleLabel: UILabel!
    var bodyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        titleLabel = UILabel()
        titleLabel.text = "Feed page"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        bodyLabel = UILabel()
        bodyLabel.text = "Complete feed page in this view controller"
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
