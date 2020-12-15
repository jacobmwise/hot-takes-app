//
//  ProfileViewController.swift
//  hotTakes
//
//  Created by Michael Crum on 12/14/20.
//

import UIKit

class ProfileViewController: UIViewController {
    var titleLabel: UILabel!
    var bodyLabel: UILabel!
    
    var profileImage: UIImageView!
    var backgroundView: UIView!
    
    var usernameLabel: UILabel!
    
    var takeNumberDisplay: StatDisplay!
    var hotVotesDisplay: StatDisplay!
    var coldVotesDisplay: StatDisplay!
    
    var takesButton: NavButton!
    var votesButton: NavButton!
    
    var pfpFraction: Float = 1/4

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = view.bounds.width * CGFloat(pfpFraction / 2)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        view.backgroundColor = .black
        profileImage = UIImageView()
        profileImage.backgroundColor = .cyan
        profileImage.contentMode = .scaleAspectFit
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.layer.cornerRadius = view.bounds.width * CGFloat(pfpFraction / 2)
        profileImage.layer.shadowColor = UIColor.gray.cgColor
        profileImage.layer.shadowOffset = CGSize(width: 0, height: 3)
        profileImage.layer.shadowOpacity = 0.5
        profileImage.layer.shadowRadius = 4
        view.addSubview(profileImage)
        
        usernameLabel = UILabel()
        usernameLabel.text = "@"+CurrentUserData.username
        usernameLabel.font = UIFont(name: "Roboto-Regular", size: 20)
        usernameLabel.textColor = .black
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.numberOfLines = 0
        usernameLabel.lineBreakMode = .byWordWrapping
        view.addSubview(usernameLabel)
        
        takeNumberDisplay = StatDisplay(countNum: 0, labelText: "Takes")
        hotVotesDisplay = StatDisplay(countNum: 0, labelText: "Hot Votes")
        coldVotesDisplay = StatDisplay(countNum: 0, labelText: "Cold Votes")
        view.addSubview(takeNumberDisplay)
        view.addSubview(hotVotesDisplay)
        view.addSubview(coldVotesDisplay)
        
        takesButton = NavButton(title: "Takes")
        takesButton.widthMultiplier = 0.45
        takesButton.setTitleColor(.black, for: .normal)
        takesButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
        votesButton = NavButton(title: "Votes")
        votesButton.widthMultiplier = 0.45
        view.addSubview(takesButton)
        view.addSubview(votesButton)
        takesButton.setupConstraints()
        votesButton.setupConstraints()
        votesButton.hideBorder()
        
        setupConstraints()
        takeNumberDisplay.setupConstraints()
        hotVotesDisplay.setupConstraints()
        coldVotesDisplay.setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: CGFloat(pfpFraction)),
            profileImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: CGFloat(pfpFraction))
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: profileImage.centerYAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(pfpFraction / 2))
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hotVotesDisplay.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            hotVotesDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            coldVotesDisplay.centerYAnchor.constraint(equalTo: hotVotesDisplay.centerYAnchor),
            coldVotesDisplay.leftAnchor.constraint(equalTo: hotVotesDisplay.rightAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            takeNumberDisplay.centerYAnchor.constraint(equalTo: hotVotesDisplay.centerYAnchor),
            takeNumberDisplay.rightAnchor.constraint(equalTo: hotVotesDisplay.leftAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            takesButton.topAnchor.constraint(equalTo: hotVotesDisplay.bottomAnchor, constant: 10),
            takesButton.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(view.bounds.width / 4))
        ])
        
    }

}

class StatDisplay: UIView{
    var label: UILabel!
    var count: UILabel!
    
    required init(countNum: Int, labelText: String){
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        count = UILabel()
        count.text = String(countNum)
        count.font = UIFont.boldSystemFont(ofSize: 20)
        count.textColor = .black
        count.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(count)
        
        label = UILabel()
        label.text = labelText
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: superview!.widthAnchor, multiplier: 0.333, constant: -40),
            self.heightAnchor.constraint(equalToConstant: 37)
        ])
        
        NSLayoutConstraint.activate([
            count.topAnchor.constraint(equalTo: self.topAnchor),
            count.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
