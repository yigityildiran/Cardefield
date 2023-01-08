//
//  AddView.swift
//  Caishen
//
//  Created by Caishen on 19/12/2022.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var vm: Stack
    @EnvironmentObject var add: StackManage
    @EnvironmentObject var fileManager: FileManagerService
    @Binding var selectedTab: Tab
    
    var body: some View {
        NavigationStack {
            VStack {
                topBar
                
                if add.isEditing { addBar }
                
                Divider()
                
                if add.isEditing { editCategoryView }
                else { categoryView }
                
                
                
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
            .padding(.horizontal)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(selectedTab: .constant(.plus))
            .environmentObject(Stack(dataService: MockDataService()))
            .environmentObject(StackManage())
            .environmentObject(FileManagerService())
    }
}



extension AddView {
    // MARK: Views
    var topBar: some View {
        HStack {
            Text("Manage")
                .font(.largeTitle.bold())
            Spacer()
            
            Image(systemName: add.isEditing ? "xmark" : "slider.horizontal.3")
                .font(.title)
                .onTapGesture {
                    withAnimation(.easeInOut) { add.isEditing.toggle() }
                }
        }
    }
    
    var addBar: some View {
        HStack {
            TextField("Please add category name", text: $add.categoryName )
                .frame(height: 50)
                .padding(.horizontal)
                .background(.thinMaterial)
                .cornerRadius(10)
            
            Button {
                addNewCategory()
                
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.orange)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                
            }
            .alert(add.errorMessage, isPresented: $add.isShowingError) { }
            
        }
        .padding(.bottom)
    }
    
    var categoryView: some View {
        ScrollView {
            ForEach(0..<vm.data.count, id: \.self) { index in
                NavigationLink { AddSetView(index: index, category: $vm.data[index]) }
            label: { CategoryView(category: vm.data[index])  }
            }
        }
    }
    
    var editCategoryView: some View {
        ScrollView {
            ForEach(0..<vm.data.count, id: \.self) { index in
                VStack {
                    
                    TextField("", text: $vm.data[index].categoryName)
                        .multilineTextAlignment(.center)
                        .font(.title.weight(.bold))
                        .padding(.vertical)
                    
                    
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.red)
                        .onTapGesture {
                            vm.data.remove(at: index)
                            fileManager.allCards = vm.data
                            fileManager.writeToFile()
                        }
                    
                }
                .foregroundColor(.black)
                .padding(.vertical)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.orange)
                .border(.secondary)
                .cornerRadius(20)
            }
        }
    }
    
    
    
    // MARK: Functions
    func addNewCategory() {
        let newCategory = Category(categoryName: add.categoryName, sets: [])
        
        if vm.data.contains(newCategory) || add.categoryName.isEmpty {
            add.isShowingError = true
            add.errorMessage = "Cannot create new category"
        } else {
            vm.data.append(newCategory)
            fileManager.allCards.append(newCategory)
            fileManager.writeToFile()
        }
    }
}
