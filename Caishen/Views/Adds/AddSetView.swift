//
//  SetsView.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import SwiftUI

struct AddSetView: View {
    @EnvironmentObject var vm: Stack
    @EnvironmentObject var add: StackManage
    @EnvironmentObject var fileManager: FileManagerService
    @Environment(\.dismiss) var dismiss

    @State var index: Int
    @Binding var category: Category
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                topBar
                
                if add.isEditing { addBar }
                Divider()
                
                if add.isEditing { editSetsView }
                else { setsView }
 
                Spacer()
            }
            .padding(.horizontal)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct AddSetView_Previews: PreviewProvider {
    static var previews: some View {
        AddSetView(index: 0, category: .constant(.sampleCategory))
            .environmentObject(Stack(dataService: MockDataService()))
            .environmentObject(StackManage())
            .environmentObject(FileManagerService())
    }
}



extension AddSetView {
    // MARK: Views
    var topBar: some View {
        HStack {
            Button {
                dismiss()
                add.isEditing = false
            }
            label: {
            Image(systemName: "arrow.left.circle")
                .font(.title)
                .foregroundColor(.black)
                .frame(maxWidth: 30)
            }
            
            Spacer()
            
            Text(vm.data[index].categoryName)
                .font(.title)
            
            Spacer()
            
            
            Image(systemName: add.isEditing ? "xmark" : "slider.horizontal.3")
                .font(.title)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        if add.isEditing {
//                            category.categoryName = add.text
                            vm.data[index].categoryName = add.text
                            fileManager.allCards = vm.data
                            fileManager.writeToFile()
                            add.isEditing = false
                        
                        } else {
                            add.isEditing = true
                            add.text = category.categoryName
                            isFocused.toggle()
                        }
                        
                    }
                }
                .frame(maxWidth: 30)
        }
        .padding(.vertical)
    }
    
    var addBar: some View {
        HStack {
            TextField("Please add set name", text: $add.setName )
                .frame(height: 50)
                .padding(.horizontal)
                .background(.thinMaterial)
                .cornerRadius(10)
            
            Button {
                addNewSet()
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
    
    var setsView: some View {
        ScrollView {
            ForEach(0..<vm.data[index].sets.count, id: \.self) { value in
                NavigationLink {  AddCardView(category: vm.data[index], set: vm.data[index].sets[value]) }
                label: { SetView(set: vm.data[index].sets[value])  }

            }
        }
    }
    
    var editSetsView: some View {
        ScrollView {
            ForEach(0..<vm.data[index].sets.count, id: \.self) { value in
                VStack {
                    TextField("", text: $vm.data[index].sets[value].setName)
                        .multilineTextAlignment(.center)
                        .font(.title.weight(.bold))
                        .padding(.vertical)


                    Image(systemName: "xmark.circle")
                        .foregroundColor(.red)
                        .onTapGesture {
                            category.sets.remove(at: value)
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
    func addNewSet() {
        let newSet = Set(setName: add.setName, cards: [])
        if category.sets.contains(newSet) || add.setName.isEmpty {
            add.isShowingError = true
            add.errorMessage = "Cannot create set category"
        } else {
            category.sets.append(newSet)
            vm.sets.append(newSet)
            fileManager.allCards = vm.data
            fileManager.writeToFile()
        }
    }
    
}


