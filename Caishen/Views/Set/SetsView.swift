//
//  SetsView.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import SwiftUI

struct SetsView: View {
    let category: Category
    
    var body: some View {
        NavigationStack {
            VStack {
                TopBarButton(text: category.categoryName)
                Divider()
                
                setsView
            }
            .padding(.horizontal)
            .toolbar(.hidden, for: .navigationBar )
        }
    }
}

struct SetsView_Previews: PreviewProvider {
    static var previews: some View {
        SetsView(category: .sampleCategory)
    }
}


extension SetsView {
    var setsView: some View {
        ScrollView {
            ForEach(0..<category.sets.count, id: \.self) { value in
                NavigationLink {  CardsView(set: category.sets[value]) }
            label: { SetView(set: category.sets[value]) }
            }
        }
    }
}




