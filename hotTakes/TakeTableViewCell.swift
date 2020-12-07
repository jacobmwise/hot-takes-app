//
//  TakeTableViewCell.swift
//  hotTakes
//
//  Created by Michael Crum on 12/6/20.
//

/**
 Take table cell
 Todo:
    1. Add UI elements to display the take and its info
    2. Impliment configure fuction to populate the cell with information about the given take
    3. Add buttons to vote a take as hot or cold
    4. Add networking to POST new vote data to backend
 */

import UIKit

class TakeTableViewCell: UITableViewCell {
    var testLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        testLabel = UILabel()
        testLabel.text = "THIS IS A TAKE CELL"
        testLabel.font = UIFont.boldSystemFont(ofSize: 16)
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(testLabel)
        
        //Customize take cell here
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            testLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            testLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        ])
    }
    
    func configure(for take: Take){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
