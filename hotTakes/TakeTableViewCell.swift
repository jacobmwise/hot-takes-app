//
//  TakeTableViewCell.swift
//  hotTakes
//
//  Created by Michael Crum on 12/14/20.
//

import UIKit

class TakeTableViewCell: UITableViewCell {
    var bodyLabel: UILabel!
    
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
        
        //contentView.layer.borderColor = UIColor.black.cgColor
        //contentView.layer.borderWidth = 0.5
        
        setupConstraints()
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
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
