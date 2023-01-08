//
//  Add.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import Foundation

class StackManage: ObservableObject {
    // MARK: Category
    @Published var categoryName: String = ""
    @Published var addCategory: Bool = false
    
    // MARK: Set
    @Published var setName: String = ""
    @Published var addSet: Bool = false 
    
    // MARK: Error
    @Published var errorMessage: String = ""
    @Published var isShowingError: Bool = false
    
    // MARK: Edit
    @Published var text: String = ""
    @Published var isEditing: Bool = false
    @Published var addNewCard: Bool = false
    
    var vm = Stack(dataService: MockDataService())
    
    
}
