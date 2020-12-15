//
//  BaseView.swift
//  hotTakes
//
//  Created by Rishab Yeddula on 12/14/20.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect){
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false;
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        //configure in child classes
    }
}
