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

class TakeCard: UIView {

    var delegate: SwipeOutDelegate?
    var takeLabel: UILabel!
    var usernameLabel: UILabel!
    var containerView: UIView!
    var votesView: VotesView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false;
        
        containerView  = {
            let card = UIView()
            card.translatesAutoresizingMaskIntoConstraints = false;
            card.backgroundColor = UIColor.init(red: 0.925, green: 0.302, blue: 0.341, alpha: 1)
            card.layer.cornerRadius = 15.0
            card.clipsToBounds = true;
            return card
        }()
        
        containerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture)))
        containerView.isUserInteractionEnabled = true
        
        addSubview(containerView)
        
        takeLabel = UILabel()
        takeLabel.translatesAutoresizingMaskIntoConstraints = false;
        takeLabel.textColor = .white
        takeLabel.text = CurrentTake.takeText
        takeLabel.font = UIFont(name: "Roboto-Bold", size: 24)
        takeLabel.textAlignment = .center
        takeLabel.sizeToFit()
        takeLabel.adjustsFontSizeToFitWidth = true;
        containerView.addSubview(takeLabel)
        
        usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false;
        usernameLabel.textColor = .white
        usernameLabel.text = "Take #" + "\(CurrentTake.takeId)"
        usernameLabel.font = UIFont(name: "Roboto-Regular", size: 16)
        usernameLabel.textAlignment = .left
        usernameLabel.sizeToFit()
        usernameLabel.adjustsFontSizeToFitWidth = true;
        containerView.addSubview(usernameLabel)
        
        votesView = VotesView()
        containerView.addSubview(votesView)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
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
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            votesView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            votesView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            votesView.centerXAnchor.constraint(equalTo: centerXAnchor),
            votesView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer){
        if gesture.state == .began {
            print("began")
        }
        else if gesture.state == .changed {
            let translation = gesture.translation(in: self)
            containerView.transform = CGAffineTransform(translationX: translation.x, y: translation.y).rotated(by: -sin(translation.x/(containerView.frame.width * 4.0)))

        }
        else if gesture.state == .ended {
                print("ended")
            if cardIsOffscreen() {
                UIView.animate(withDuration: 0.5, animations: {
                    self.containerView.center = CGPoint(x:self.containerView.center.x + 200, y: self.containerView.center.y-50)
                }, completion: {_ in print("outtie")
                    self.delegate?.didSwipeOut(self)})
            }
            else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                    self.containerView.transform = .identity
                })
            }
        }
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow == nil {
        } else {
            UIView.animate(withDuration: 1.0) {
                    self.alpha = 1.0
                }
        }
    }
    
    func cardIsOffscreen() -> Bool {
        return (containerView.frame.midX+containerView.frame.maxX)/2 > window!.frame.maxX
    }
    
    func resetCard() {
        
    }
    
}
