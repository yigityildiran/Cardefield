//
//  FilesView.swift
//  Caishen
//
//  Created by Caishen on 19/12/2022.
//

import SwiftUI

struct FilesView: View {
    @EnvironmentObject var vm: Stack
    @Binding var selectedTab: Tab
    @State var showCategory: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("Files")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
            
                Divider()
                    .padding(.bottom)
                
                HStack {
                    Button { showCategory = true }
                    label: {
                        Text("Categories")
                            .foregroundColor(showCategory ? .black : .orange )
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(showCategory ? .orange : .white)
                            .cornerRadius(10)
                            .shadow(radius: showCategory ? 0 : 2 )
                    }
                    Spacer()
                    Button { showCategory = false }
                    label: {
                        Text("Sets")
                            .foregroundColor(showCategory ? .orange : .black )
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(showCategory ? .white : .orange)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: showCategory ? 2 : 0 )
                    }
                    
                        
                }
            
                if showCategory {  CategoriesView() }
                else { setView }
                
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
            .padding(.horizontal)
            .onAppear { vm.sets = vm.data.flatMap { $0.sets } }
        }
    }
}

struct FilesView_Previews: PreviewProvider {
    static var previews: some View {
        FilesView(selectedTab: .constant(.folder))
            .environmentObject(Stack(dataService: MockDataService()))
    }
}



extension FilesView {
    // MARK: Views
    var setView: some View {
        ScrollView {
            ForEach(vm.sets, id: \.self) { value in
                NavigationLink { CardsView(set: value) }
                label: { SetView(set: value) }
            }
        }
    }
    var categoryView: some View {
        ScrollView {
            ForEach(0..<vm.data.count, id: \.self) { index in
                NavigationLink { SetsView(category: vm.data[index]) }
                label: {CategoryView(category: vm.data[index]) }
            }
        }
    }
}
