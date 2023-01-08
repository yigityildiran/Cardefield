//
//  HomeView.swift
//  Caishen
//
//  Created by Caishen on 19/12/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: Stack
    @FocusState private var searchIsFocused: Bool
    @Binding var selectedTab: Tab
    var body: some View {
        NavigationStack {
            VStack {
                if !vm.isSearch {
                    Text("Home")
                        .font(.largeTitle.bold())
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                
                searchBarView
                
                if vm.isSearch {
                    if vm.searchCategory { searchCategoryResultView }
                    else { searchSetResultView }
                } else { recentlyUsedSetsView }
                
                Spacer()
                
                CustomTabBar(selectedTab: $selectedTab)
            }
            .padding(.horizontal)
            .onAppear { vm.sets = vm.data.flatMap { $0.sets } }
            .onChange(of: vm.searchTerm) { newValue in
                if vm.searchCategory { vm.searchCategory(newValue) }
                else { vm.searchSet(newValue) }
            }
            .onDisappear { vm.isSearch = false }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedTab: .constant(.house))
            .environmentObject(Stack(dataService: MockDataService()))
    }
}



extension HomeView {
    // MARK: View
    var searchBarView: some View {
        HStack {
            Image(systemName: vm.isSearch ? "xmark.circle.fill" : "magnifyingglass")
                .foregroundColor(.orange)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        if vm.isSearch {
                            vm.isSearch = false
                            searchIsFocused = false
                        }
                    }
                }
            
            ZStack(alignment: .leading) {
                if vm.searchTerm.isEmpty { Text(vm.searchCategory ? "Search category" : "Search set") }
                
                
                TextField("", text: $vm.searchTerm)
                    .focused($searchIsFocused)
                    .overlay(alignment: .trailing) {
                        HStack {
                            Image(systemName: "lanyardcard")
                                .onTapGesture { vm.searchCategory = true }
                                .foregroundColor(vm.searchCategory ? .orange : .gray)
                                .fontWeight(.semibold)
                            Image(systemName: "newspaper")
                                .onTapGesture { vm.searchCategory = false }
                                .foregroundColor(vm.searchCategory ? .gray : .orange)
                                .fontWeight(.semibold)
                        }
                        .opacity(vm.isSearch ? 1 : 0)
                        
                    }
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .onTapGesture {  withAnimation(.easeInOut) { vm.isSearch = true } }
       
        
    }
    
    var searchCategoryResultView: some View {
        ScrollView {
            ForEach(vm.searchTerm.isEmpty ? vm.data : vm.searchCategoryResult, id: \.self) { value in
                NavigationLink { SetsView(category: value) }
                label: { CategoryView(category: value)  }
            }
        }
    }
    
    var searchSetResultView: some View {
        ScrollView {
            ForEach(vm.searchTerm.isEmpty ? vm.sets : vm.searchSetResult, id: \.self) { value in
                NavigationLink { CardsView(set: value) }
                label: { SetView(set: value)  }
            }
        }
    }
    
    var recentlyUsedSetsView: some View {
        VStack {
            Text("Recently used")
                .font(.largeTitle.bold())
                .frame(maxWidth:.infinity, alignment: .leading)
            
            ScrollView {
                ForEach(vm.recentlyUsed, id: \.self) { value in
                    NavigationLink { CardsView(set: value) }
                    label: { SetView(set: value) }
                }
            }
        }
    }
    
    
}
