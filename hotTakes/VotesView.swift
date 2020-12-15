//
//  VotesView.swift
//  hotTakes
//
//  Created by Rishab Yeddula on 12/15/20.
//

import UIKit

class VotesView: UIView {

    var flame: UIImageView!
    var ice: UIImageView!
    var hotTakeLabel: UILabel!
    var coldTakeLabel: UILabel!
    var hotVotes: Int!
    var coldVotes: Int!
    var container: UIStackView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false;
        
        hotVotes = CurrentTake.hotVotes
        coldVotes = CurrentTake.coldVotes
        
        flame = UIImageView()
        flame.image = UIImage(named: "flame")
        flame.contentMode = .scaleAspectFit
        flame.translatesAutoresizingMaskIntoConstraints = false
        
        ice = UIImageView()
        ice.image = UIImage(named: "ice")
        ice.contentMode = .scaleAspectFit
        ice.translatesAutoresizingMaskIntoConstraints = false
        
        hotTakeLabel = UILabel()
        hotTakeLabel.text = "\(hotVotes!)"
        hotTakeLabel.translatesAutoresizingMaskIntoConstraints = false;
        hotTakeLabel.textAlignment = .center
        hotTakeLabel.font = UIFont(name: "Roboto-Bold", size: 18)
        hotTakeLabel.textColor = .white

        
        coldTakeLabel = UILabel()
        coldTakeLabel.text = "\(coldVotes!)"
        coldTakeLabel.translatesAutoresizingMaskIntoConstraints = false;
        coldTakeLabel.textAlignment = .center
        coldTakeLabel.font = UIFont(name: "Roboto-Bold", size: 18)
        coldTakeLabel.textColor = .white
        
        container = {
            let c = UIStackView(arrangedSubviews: [self.hotTakeLabel, self.flame, self.coldTakeLabel, self.ice])
            c.translatesAutoresizingMaskIntoConstraints = false
            c.spacing = 40
            c.distribution = .fillEqually
            return c
        }()
        
        addSubview(container)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor),
            container.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
