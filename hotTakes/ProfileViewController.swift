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
    
    var likedTakesTableView: TakeCollectionTableViewController!
    var ownTakesTableView: TakeCollectionTableViewController!
    
    var pfpFraction: Float = 1/4
    
    var currentView: UIViewController!
    
    var mainViewConstraints: [NSLayoutConstraint]!

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
        votesButton.setTitleColor(.black, for: .normal)
        votesButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
        view.addSubview(takesButton)
        view.addSubview(votesButton)
        takesButton.setupConstraints()
        votesButton.setupConstraints()
        votesButton.hideBorder()
        votesButton.addTarget(self, action: #selector(votesPressed), for: .touchUpInside)
        takesButton.addTarget(self, action: #selector(takesPressed), for: .touchUpInside)
        
        setupConstraints()
        
        likedTakesTableView = TakeCollectionTableViewController()
        likedTakesTableView.postDelegate = self
        likedTakesTableView.voteDelegate = self
        likedTakesTableView.type = .liked
        ownTakesTableView = TakeCollectionTableViewController()
        ownTakesTableView.postDelegate = self
        ownTakesTableView.voteDelegate = self
        addChild(ownTakesTableView)
        ownTakesTableView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ownTakesTableView.view)
        ownTakesTableView.didMove(toParent: self)
        mainViewConstraints = [
            ownTakesTableView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ownTakesTableView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ownTakesTableView.view.topAnchor.constraint(equalTo: takesButton.bottomAnchor),
            ownTakesTableView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(mainViewConstraints)
        currentView = ownTakesTableView
        
        takeNumberDisplay.setupConstraints()
        hotVotesDisplay.setupConstraints()
        coldVotesDisplay.setupConstraints()
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
            cont.view.topAnchor.constraint(equalTo: takesButton.bottomAnchor),
            cont.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(mainViewConstraints)
        currentView = cont
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
        
        NSLayoutConstraint.activate([
            votesButton.topAnchor.constraint(equalTo: hotVotesDisplay.bottomAnchor, constant: 10),
            votesButton.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(view.bounds.width * 3 / 4))
        ])
        
    }
    
    @objc func takesPressed(){
        takesButton.showBorder()
        votesButton.hideBorder()
        presentScreen(cont: ownTakesTableView)
    }

    @objc func votesPressed(){
        takesButton.hideBorder()
        votesButton.showBorder()
        presentScreen(cont: likedTakesTableView)
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

extension ProfileViewController: voteCountDelegate{
    func takeVoteCount(coldCount: Int, hotCount: Int) {
        coldVotesDisplay.count.text = String(coldCount)
        hotVotesDisplay.count.text = String(hotCount)
    }
}

extension ProfileViewController: postCountDelegate{
    func takePostCount(postCount: Int) {
        takeNumberDisplay.count.text = String(postCount)
    }
}
