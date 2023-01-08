//
//  Stack.swift
//  Caishen
//
//  Created by Caishen on 19/12/2022.
//

import Foundation


class Stack: ObservableObject {
    // MARK: All data
    @Published var data: [Category] = []
    
    // MARK: Searching
    @Published var searchCategoryResult: [Category] = []
    @Published var sets: [Set] = [] 
    @Published var searchSetResult: [Set] = []
    @Published var recentlyUsed: [Set] = []
    
    // MARK: Search components
    @Published var searchTerm: String = ""
    @Published var isSearch: Bool = false
    @Published var searchCategory: Bool = false
    
    
    // MARK: Data service
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        getSaveData()
    }
    
    func getSaveData() {
        Task { @MainActor in
            data = try await dataService.getData()
            sets = try await dataService.getData().flatMap { $0.sets }
        }
    }
}


extension Stack {
    // MARK: Functions
    func searchCategory(_ value: String) {
        searchCategoryResult = data.filter { Category in
            Category.categoryName.lowercased().contains(value.lowercased())
        }
    }

    func searchSet(_ value: String) {
        searchSetResult = sets.filter { Set in
            Set.setName.lowercased().contains(value.lowercased())
        }
    }
    
    
}
