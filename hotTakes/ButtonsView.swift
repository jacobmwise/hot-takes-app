//
//  ButtonsView.swift
//  hotTakes
//
//  Created by Rishab Yeddula on 12/14/20.
//

import UIKit

class ButtonsView: UIView {
    
    var hotTakeButtonPressed: Bool = false
    var coldTakeButtonPressed: Bool = false
    var hotButton: UIButton!
    var coldButton: UIButton!
    var container: UIStackView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false;
        
        hotButton = UIButton()
        hotButton.setImage(UIImage(named: "flame"), for: .normal)
        hotButton.addTarget(self, action: #selector(hot), for: .touchUpInside)
        hotButton.translatesAutoresizingMaskIntoConstraints = false
        hotButton.clipsToBounds = true
        
        coldButton = UIButton()
        coldButton.setImage(UIImage(named: "ice"), for: .normal)
        coldButton.addTarget(self, action: #selector(hot), for: .touchUpInside)
        coldButton.translatesAutoresizingMaskIntoConstraints = false
        coldButton.clipsToBounds = true
        
        container = {
            let c = UIStackView(arrangedSubviews: [self.hotButton, self.coldButton])
            c.translatesAutoresizingMaskIntoConstraints = false
            c.spacing = 40
            c.distribution = .fillEqually
            return c
        }()
        
        addSubview(container)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor),
            container.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    @objc func hot(){
        if(hotTakeButtonPressed == false){
            CurrentTake.hotVotes += 1
            NetworkManager.vote(value: true, user_id: CurrentUserData.userId, take_id: CurrentTake.takeId){_ in }
            hotTakeButtonPressed = true
        }
    }
    
    @objc func cold(){
        if(coldTakeButtonPressed == false){
            CurrentTake.coldVotes += 1
            NetworkManager.vote(value: false, user_id: CurrentUserData.userId, take_id: CurrentTake.takeId){_ in }
            coldTakeButtonPressed = true
        }
    }
    
    func didSwipeOut() {
        print("changed")
        hotTakeButtonPressed = false;
        coldTakeButtonPressed = false;
    }
}
