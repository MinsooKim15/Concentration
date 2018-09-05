//
//  Card.swift
//  Concentration
//
//  Created by minsoo kim on 2018. 8. 6..
//  Copyright © 2018년 minsoo kim. All rights reserved.
//

import Foundation
struct Card: Hashable
{
    var hashVaule: Int {return identifier}
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}