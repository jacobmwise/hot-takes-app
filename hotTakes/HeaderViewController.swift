//
//  HeaderViewController.swift
//  hotTakes
//
//  Created by Michael Crum on 12/14/20.
//

import UIKit

enum Screens{
    case feed, post, profile
}

protocol HeaderDelegate: class{
    func showScreen(screen: Screens)
}

class HeaderViewController: UIViewController {
    
    var titleLabel:  UILabel!
    var titleFlame: UIImageView!
    
    var feedButton: NavButton!
    var postButton: NavButton!
    var profileButton: NavButton!
    
    var delegate: HeaderDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = .black
        
        titleLabel = UILabel()
        titleLabel.text = "HOT OR COLD?"
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 35)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleFlame = UIImageView()
        titleFlame.image = UIImage(named: "flame")
        titleFlame.contentMode = .scaleAspectFit
        titleFlame.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleFlame)
        
        feedButton = NavButton(title: "FEED")
        postButton = NavButton(title: "POST")
        profileButton = NavButton(title: "PROFILE")
        view.addSubview(feedButton)
        view.addSubview(postButton)
        view.addSubview(profileButton)
        feedButton.setupConstraints()
        postButton.setupConstraints()
        profileButton.setupConstraints()
        postButton.hideBorder()
        profileButton.hideBorder()
        
        feedButton.addTarget(self, action: #selector(feedPressed), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(postPressed), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profilePressed), for: .touchUpInside)

        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleFlame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleFlame.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleFlame.heightAnchor.constraint(equalToConstant: 50),
            titleFlame.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: titleFlame.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleFlame.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            feedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            feedButton.topAnchor.constraint(equalTo: titleFlame.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            postButton.leadingAnchor.constraint(equalTo: feedButton.trailingAnchor, constant: 10),
            postButton.topAnchor.constraint(equalTo: titleFlame.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            profileButton.leadingAnchor.constraint(equalTo: postButton.trailingAnchor, constant: 10),
            profileButton.topAnchor.constraint(equalTo: titleFlame.bottomAnchor, constant: 10)
        ])
    }
    
    @objc func feedPressed(){
        feedButton.showBorder()
        postButton.hideBorder()
        profileButton.hideBorder()
        delegate?.showScreen(screen: .feed)
    }

    @objc func postPressed(){
        feedButton.hideBorder()
        postButton.showBorder()
        profileButton.hideBorder()
        delegate?.showScreen(screen: .post)
    }

    @objc func profilePressed(){
        postButton.hideBorder()
        feedButton.hideBorder()
        profileButton.showBorder()
        delegate?.showScreen(screen: .profile)
    }
}

class NavButton: UIButton {
    var border = UIView()
    var widthMultiplier = 0.2
    
    required init(title: String){
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addBottomBorder(with: UIColor(red: 0.925, green: 0.302, blue: 0.341, alpha: 1), andWidth: 2)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: superview!.widthAnchor, multiplier: CGFloat(widthMultiplier)),
            self.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func hideBorder(){
        border.isHidden = true
    }
    
    func showBorder(){
        border.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
