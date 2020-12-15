//
//  TakeTableViewCell.swift
//  hotTakes
//
//  Created by Michael Crum on 12/14/20.
//

import UIKit

enum hotOrCold{
    case hot, cold
}

class TakeTableViewCell: UITableViewCell {
    var bodyLabel: UILabel!
    var profileImage: UIImageView!
    
    var coldCounter: VoteCounter!
    var hotCounter: VoteCounter!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        
        bodyLabel = UILabel()
        bodyLabel.text = "This is an example post"
        bodyLabel.font = UIFont.boldSystemFont(ofSize: 15)
        bodyLabel.textColor = .black
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        bodyLabel.numberOfLines = 0
        contentView.addSubview(bodyLabel)
        
        profileImage = UIImageView()
        profileImage.backgroundColor = .cyan
        profileImage.contentMode = .scaleAspectFit
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.layer.cornerRadius = 25
        contentView.addSubview(profileImage)
        
        hotCounter = VoteCounter(type: .hot)
        coldCounter = VoteCounter(type: .cold)
        contentView.addSubview(hotCounter)
        contentView.addSubview(coldCounter)
        
        setupConstraints()
        
        hotCounter.setupConstraints()
        coldCounter.setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            bodyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            coldCounter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            coldCounter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            hotCounter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hotCounter.trailingAnchor.constraint(equalTo: coldCounter.leadingAnchor, constant: -10)
        ])
    }

    func configure(for take: Take) {
        bodyLabel.text = take.text
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VoteCounter: UIView{
    var type: hotOrCold!
    var hotIcon: UIImageView!
    var coldIcon: UIImageView!
    var count: UILabel!
    var height: Float = 30
    
    required init(type: hotOrCold){
        super.init(frame: .zero)
        self.type = type
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        count = UILabel()
        count.text = "0"
        count.font = UIFont.boldSystemFont(ofSize: 15)
        count.textColor = .black
        count.translatesAutoresizingMaskIntoConstraints = false
        count.lineBreakMode = NSLineBreakMode.byWordWrapping
        count.numberOfLines = 0
        self.addSubview(count)
        
        hotIcon = UIImageView()
        coldIcon = UIImageView()
        hotIcon.image = UIImage(named: "flame")
        hotIcon.translatesAutoresizingMaskIntoConstraints = false
        coldIcon.image = UIImage(named: "ice")
        coldIcon.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(hotIcon)
        self.addSubview(coldIcon)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: CGFloat(height*1.5)),
            self.heightAnchor.constraint(equalToConstant: CGFloat(height))
        ])
        
        if type == .hot {
            NSLayoutConstraint.activate([
                hotIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                hotIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                hotIcon.widthAnchor.constraint(equalToConstant: CGFloat(height)),
                hotIcon.heightAnchor.constraint(equalToConstant: CGFloat(height))
            ])
            NSLayoutConstraint.activate([
                count.leadingAnchor.constraint(equalTo: hotIcon.trailingAnchor, constant: 5),
                count.centerYAnchor.constraint(equalTo: hotIcon.centerYAnchor)
            ])
            coldIcon.isHidden = true
        }else{
            NSLayoutConstraint.activate([
                coldIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                coldIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                coldIcon.widthAnchor.constraint(equalToConstant: CGFloat(height)),
                coldIcon.heightAnchor.constraint(equalToConstant: CGFloat(height))
            ])
            NSLayoutConstraint.activate([
                count.leadingAnchor.constraint(equalTo: coldIcon.trailingAnchor, constant: 5),
                count.centerYAnchor.constraint(equalTo: coldIcon.centerYAnchor)
            ])
            hotIcon.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
