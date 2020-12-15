//
//  ButtonsView.swift
//  hotTakes
//
//  Created by Rishab Yeddula on 12/14/20.
//

import UIKit

class ButtonsView: BaseView {

    lazy var hotButton: UIButton = {
        let fire = ButtonFactory.button(image: UIImage(named: "flame")!, cornerRadius: 0, target: self, selector: #selector(hot), sizeToFit: true).createButton
        return fire
    }()
    
    lazy var coldButton: UIButton = {
        let ice = ButtonFactory.button(image: UIImage(named: "ice")!, cornerRadius: 0, target: self, selector: #selector(cold), sizeToFit: true).createButton
        return ice
    }()
    
    lazy var container: UIStackView = {
            let c = UIStackView(arrangedSubviews: [
                self.hotButton, self.coldButton
                ])
            c.translatesAutoresizingMaskIntoConstraints = false
            c.spacing = 20
            c.distribution = .fillEqually
            return c
        }()
    
    override func setupViews() {
        addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor),
            container.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    @objc func hot(){
        print("hot")
    }
    
    @objc func cold(){
        print("cold")
    }
}
