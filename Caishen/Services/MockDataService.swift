//
//  MockDataService.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import Foundation

class MockDataService: DataServiceProtocol {
    func getData() async throws -> [Category] { return testData }
    let testData: [Category] = [
        Category(categoryName: "Biology", sets: sampleSet1),
        Category(categoryName: "History", sets: sampleSet2),
        Category(categoryName: "Physics", sets: sampleSet3),
    ]

    // MARK: Sample sets
    static let sampleSet1 = [
        Set(setName: "Human", cards: sampleCards1),
        Set(setName: "Organelles", cards: sampleCards2),
        Set(setName: "Animal", cards: sampleCards3),
    ]
    static let sampleSet2 = [
        Set(setName: "Modernity", cards: sampleCards1),
        Set(setName: "Antiquity", cards: sampleCards2),
        Set(setName: "Middle Ages", cards: sampleCards3),
    ]
    static let sampleSet3 = [
        Set(setName: "Nuclear physics", cards: sampleCards1),
        Set(setName: "Classical physic", cards: sampleCards2),
        Set(setName: "Quantum physic", cards: sampleCards3),
    ]
    
    // MARK: Sample cards
    static let sampleCards1 =  [
        Card(term: "Term-1", definition: "Definition-1"),
        Card(term: "Term-2", definition: "Definition-2"),
        Card(term: "Term-3", definition: "Definition-3"),
    ]
    static let sampleCards2 =  [
        Card(term: "Term-1", definition: "Definition-1"),
        Card(term: "Term-2", definition: "Definition-2"),
        Card(term: "Term-3", definition: "Definition-3"),
        Card(term: "Term-4", definition: "Definition-4"),
        Card(term: "Term-5", definition: "Definition-5"),
        Card(term: "Term-6", definition: "Definition-6"),
        Card(term: "Term-7", definition: "Definition-7"),
        Card(term: "Term-8", definition: "Definition-8"),
    ]
    static let sampleCards3 =  [
        Card(term: "Term-1", definition: "Definition-1"),
        Card(term: "Term-2", definition: "Definition-2"),
        Card(term: "Term-3", definition: "Definition-3"),
        Card(term: "Term-4", definition: "Definition-4"),
        Card(term: "Term-5", definition: "Definition-5"),
    ]
    
}
