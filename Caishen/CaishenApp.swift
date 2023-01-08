//
//  CaishenApp.swift
//  Caishen
//
//  Created by Caishen on 19/12/2022.
//

import SwiftUI

@main
struct CaishenApp: App {
//    @StateObject private var vm: Stack = Stack(dataService: MockDataService()) // Fake data
    
    @StateObject private var vm: Stack = Stack(dataService: FileManagerService()) // Real data
    @StateObject private var addNew = StackManage()
    @StateObject private var fileManager = FileManagerService()
    
    @State private var selectedTab: Tab = .house
    var body: some Scene {
        WindowGroup {
            switch selectedTab {
            case .house:
                HomeView(selectedTab: $selectedTab)
                    .environmentObject(vm)
                    .environmentObject(addNew)
                    .environmentObject(fileManager)
            case .plus:
                AddView(selectedTab: $selectedTab)
                    .environmentObject(vm)
                    .environmentObject(addNew)
                    .environmentObject(fileManager)
            case .folder:
                FilesView(selectedTab: $selectedTab)
                    .environmentObject(vm)
                    .environmentObject(addNew)
                    .environmentObject(fileManager)
            }
        }
    }
}
