//
//  TakeTableViewCell.swift
//  hotTakes
//
//  Created by Michael Crum on 12/14/20.
//

import UIKit

class TakeTableViewCell: UITableViewCell {
    var bodyLabel: UILabel!
    var profileImage: UIImageView!
    
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
        
        //contentView.layer.borderColor = UIColor.lightGray.cgColor
        //contentView.layer.borderWidth = 0.5
        
        setupConstraints()
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
    }

    func configure(for take: Take) {
        bodyLabel.text = take.text
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
