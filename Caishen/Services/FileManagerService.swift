//
//  FileManagerService.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import Foundation

class FileManagerService: DataServiceProtocol, ObservableObject {
    
    func getData() async throws -> [Category] {
        return allCards
    }
    
    private let fm = FileManager.default
    var allCards: [Category] = []
    
    init() {
        getCardsFromJson()
    }
  
    
    
}

// MARK: JSON Functions
extension FileManagerService {
    
    func getCardsFromJson() {
        if fm.fileExists(atPath: jsonURL().path) {
            decodeData(fromURL: jsonURL())
        } else {
            self.allCards = Bundle.main.decode("Cards.json")
        }
    }
    
    
    func jsonURL() -> URL {
        do {
            let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return documentDirectory.appendingPathComponent("Flashcards.json")
        } catch {
            fatalError("Couldn't create URL")
        }
    }
    
    
    func decodeData(fromURL url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodeData = try decoder.decode([Category].self, from: data)
            self.allCards = decodeData
        } catch {
            print(error)
            assertionFailure("Error decoding Json")
        }
    }
    
    
    func writeToFile() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(allCards.self)
            try data.write(to: jsonURL())
            print("Data write to file ")
        } catch {
            print(error)
        }
    }
    
}

