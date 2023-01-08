//
//  Card.swift
//  Caishen
//
//  Created by Caishen on 19/12/2022.
//

import Foundation

// MARK: Main group - contains sets
struct Category: Codable, Hashable {
    var categoryName: String
    var sets: [Set]
    
    static var sampleCategory = MockDataService().testData[0]
}


// MARK: Set - containg cards
struct Set: Codable, Hashable {
    var setName: String
    var cards: [Card]
    
    static var sampleSet = MockDataService().testData[0].sets[0]
}


// MARK: One card
struct Card: Codable, Hashable {
    var term: String
    var definition: String
    
    static var sampleCard = MockDataService().testData[0].sets[0].cards[0]
}
