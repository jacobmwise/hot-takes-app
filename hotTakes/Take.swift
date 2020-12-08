//
//  Take.swift
//  hotTakes
//
//  Created by Michael Crum on 12/6/20.
//

import Foundation

class Take {
    var author: String
    var text: String
    var hotVotes: Int
    var coldVotes: Int
    
    init(author: String, text: String, hotVotes: Int, coldVotes: Int){
        self.author = author
        self.text = text
        self.hotVotes = hotVotes
        self.coldVotes = coldVotes
    }
    
    func getPercentage() -> Float {
        return Float(hotVotes/(hotVotes + coldVotes))
    }
}
