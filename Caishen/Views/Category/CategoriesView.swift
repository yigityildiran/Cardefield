//
//  CategoriesView.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var vm: Stack
    var body: some View {
        NavigationStack {
            VStack {
                categoriesView
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
        .environmentObject(Stack(dataService: MockDataService()))
    }
}

extension CategoriesView {
    var categoriesView: some View {
        ScrollView {
            ForEach(vm.data, id: \.self) { value in
                NavigationLink {  SetsView(category: value) }
                label: { CategoryView(category: value) }
            }
        }
    }
}
