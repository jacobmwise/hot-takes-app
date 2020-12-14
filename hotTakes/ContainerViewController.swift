//
//  ContainerViewController.swift
//  hotTakes
//
//  Created by Michael Crum on 12/14/20.
//

import UIKit

class ContainerViewController: UIViewController {
    var headerController: HeaderViewController!
    
    var feedController: FeedViewController!
    var profileController: ProfileViewController!
    var newPostController: NewPostViewController!
    
    var currentView: UIViewController!
    
    var mainViewConstraints: [NSLayoutConstraint]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerController = HeaderViewController()
        headerController.delegate = self
        addChild(headerController)
        headerController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerController.view)
        headerController.didMove(toParent: self)
        
        setupConstraints()
        
        feedController = FeedViewController()
        profileController = ProfileViewController()
        newPostController = NewPostViewController()
        
        addChild(feedController)
        feedController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(feedController.view)
        feedController.didMove(toParent: self)
        mainViewConstraints = [
            feedController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedController.view.topAnchor.constraint(equalTo: headerController.view.bottomAnchor),
            feedController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(mainViewConstraints)
        currentView = feedController
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            headerController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerController.view.heightAnchor.constraint(equalToConstant: 100),
            headerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func presentScreen(cont: UIViewController){
        currentView.willMove(toParent: nil)
        NSLayoutConstraint.deactivate(mainViewConstraints)
        currentView.view.removeFromSuperview()
        currentView.removeFromParent()
        
        addChild(cont)
        cont.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cont.view)
        cont.didMove(toParent: self)
        mainViewConstraints = [
            cont.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cont.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cont.view.topAnchor.constraint(equalTo: headerController.view.bottomAnchor),
            cont.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(mainViewConstraints)
        currentView = cont
    }
}

extension ContainerViewController: HeaderDelegate{
    func showScreen(screen: Screens){
        switch screen {
        case .feed:
            presentScreen(cont: feedController)
        case .profile:
            presentScreen(cont: profileController)
        case .post:
            presentScreen(cont: newPostController)
        }
    }
}
