//
//  AddCardView.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import SwiftUI

struct AddCardView: View {
    @EnvironmentObject var vm: Stack
    @EnvironmentObject var add: StackManage
    @EnvironmentObject var fileManager: FileManagerService
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    
    @State var category: Category
    @State var set: Set
    
    var body: some View {
        VStack {
            topBar
            Divider()
            
            ScrollView {
                ForEach(0..<set.cards.count, id: \.self) { index in
                    VStack {
                        VStack(alignment: .leading) {
                            
                            HStack {
                                TextField("", text: $set.cards[index].term)
                                
                                Spacer()
                                
                                Button { set.cards.remove(at: index) }
                                label: {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                                }
                                
                            }
                            
                            Divider()
                            
                            Text("Term")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading) {
                            TextField("", text: $set.cards[index].definition)
                            
                            Divider()
                            
                            Text("Definition")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal)
                    .background(Color.orange)
                    .cornerRadius(10)
                }
            }
            Spacer()
            
        }
        .padding(.horizontal)
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView(category: .sampleCategory, set: .sampleSet)
            .environmentObject(Stack(dataService: MockDataService()))
            .environmentObject(StackManage())
            .environmentObject(FileManagerService())
    }
}



extension AddCardView {
    // MARK: Views
    var topBar: some View {
        HStack {
            Button { dismissView() }
            label: {
            Image(systemName: "arrow.left.circle")
                .font(.title)
                .foregroundColor(.black)
                .frame(maxWidth: 30)
            }
            
            Spacer()
            
            Text(set.setName)
                .font(.title)
                .frame(maxHeight: 30)
            
            
            Spacer()
            
            
            Image(systemName: "plus.circle")
                .font(.title)
                .onTapGesture {
                    withAnimation(.easeInOut) { addNewCard() }
                }
                .frame(maxWidth: 30)
                .alert(add.errorMessage, isPresented: $add.isShowingError) { }
        }
        .padding(.vertical)
    }
    
    
    // MARK: Function
    func saveCards() {
        if let currentCategory = vm.data.firstIndex(where: {$0.categoryName == category.categoryName }) {
            if let currentSet = vm.data[currentCategory].sets.firstIndex(where: {$0.setName == set.setName}) {
                vm.data[currentCategory].sets[currentSet] = set
                fileManager.allCards = vm.data
                fileManager.writeToFile()
            }
        }
    }
    
    func addNewCard() {
        if !(set.cards.firstIndex(where: { $0.term.isEmpty || $0.definition.isEmpty  }) != nil) {
            set.cards.append(Card(term: "", definition: ""))
            guard let card = set.cards.last else { return }
            set.cards.bringToFront(item: card)
        } else {
            add.isShowingError = true
            add.errorMessage = "Complete term/definition"
        }
    }
    
    
    func dismissView() {
        if !(set.cards.firstIndex(where: { $0.term.isEmpty || $0.definition.isEmpty  }) != nil) {
            saveCards()
            add.isEditing = false
            dismiss()
        } else {
            add.isShowingError = true
            add.errorMessage = "Complete term/definition"
        }
    }
}
