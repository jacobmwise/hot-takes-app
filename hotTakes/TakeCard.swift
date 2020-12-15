//
//  TakeCard.swift
//  hotTakes
//
//  Created by Rishab Yeddula on 12/14/20.
//

/**
 TakeCard View - view for a card that displays a take
 
 TODO
 1. Add networking
 */

import Foundation
import UIKit

class TakeCard: BaseView {

    let containerView: BaseView = {
        let card = BaseView()
        card.backgroundColor = UIColor.init(red: 0.925, green: 0.302, blue: 0.341, alpha: 1)
        card.layer.cornerRadius = 15.0
        card.clipsToBounds = true;
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        gesture.numberOfTapsRequired = 2;
        card.addGestureRecognizer(gesture)
        return card
    }()
    
    let takeLabel = LabelFactory.labelView(text: "Cornell is the best ivy of them all!", textColor: .white, font: UIFont(name: "Roboto-Bold", size: 24)!, textAlignment: .center, sizeToFit: true, adjustToFit: true).newLabel
    
    let usernameLabel = LabelFactory.labelView(text: "@turtwig59", textColor: .white, font: UIFont(name:"Roboto-Bold", size: 16)!, textAlignment: .left, sizeToFit:true, adjustToFit: true).newLabel
    
    override func setupViews() {
        addSubview(containerView)
        containerView.addSubview(takeLabel)
        containerView.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            takeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            takeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            takeLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 10),
            usernameLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10)
        ])
    }
    
    @objc func doubleTapped(){
        print("tapped")
        serveTake()
    }
    
    func serveTake() {
        NetworkManager.getTakes(user_id: CurrentUserData.userId){takeCollection in
            let x : Int = takeCollection[0].id
            self.takeLabel.text = takeCollection[0].text
            self.usernameLabel.text = "Take number: " + "\(x)"
        }}
    
}
