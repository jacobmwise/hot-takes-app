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

class FeedViewController: UIViewController, SwipeOutDelegate {
    
    var takes = [Take]()
    var takeDisplay: TakeCard!
    var buttonDisplay: ButtonsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        serveTake()
        buttonDisplay = ButtonsView()
        view.addSubview(self.buttonDisplay)
        setupButtonConstraints()
    }
    
    func setupTakeConstraints(){
        NSLayoutConstraint.activate([
            takeDisplay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            takeDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            takeDisplay.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            takeDisplay.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
    }
    
    func setupButtonConstraints(){
        NSLayoutConstraint.activate([
            buttonDisplay.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonDisplay.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            buttonDisplay.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10),
            buttonDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func didSwipeOut(_ sender: TakeCard){
        print("didSwipeOut Executed")
        self.takeDisplay.removeFromSuperview()
        self.buttonDisplay.didSwipeOut()
        serveTake()
        
    }
    
    func serveTake() {
        NetworkManager.getTakes(user_id: CurrentUserData.userId){takeCollection in
            let take: Take = takeCollection.randomElement()!
            CurrentTake.coldVotes = take.cold_count
            CurrentTake.hotVotes = take.hot_count
            CurrentTake.takeText = take.text
            CurrentTake.takeId = take.id
            
            self.takeDisplay = TakeCard()
            self.takeDisplay.delegate = self
            
            self.takeDisplay.alpha = 0.0
            self.view.addSubview(self.takeDisplay)
            self.setupTakeConstraints()
            
            print(CurrentTake.takeText)
        }
    }
}
