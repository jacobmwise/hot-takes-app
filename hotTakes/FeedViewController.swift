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

    var takeDisplay: TakeCard = {
        let tc = TakeCard()
        tc.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipeCard(sender:))))
        return tc
    }()
    
    var buttonDisplay: ButtonsView = {
        let buttons = ButtonsView()
        return buttons
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(takeDisplay)
        view.addSubview(buttonDisplay)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            takeDisplay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            takeDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            takeDisplay.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            takeDisplay.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            buttonDisplay.topAnchor.constraint(equalTo: takeDisplay.bottomAnchor, constant: 10),
            buttonDisplay.widthAnchor.constraint(equalTo: takeDisplay.widthAnchor),
            buttonDisplay.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            buttonDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func swipeCard(sender: UIPanGestureRecognizer) {
            sender.swipeView(takeDisplay)
       }
}
