//
//  CategoryView.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import SwiftUI

struct CategoryView: View {
    let category: Category
    var body: some View {
        VStack {
            
            Text(category.categoryName)
                .font(.title.weight(.bold))
                .padding(.vertical)
            
            Text(category.sets.count == 0 ? "\(category.sets.count) set" : "\(category.sets.count) sets")

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

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: .sampleCategory)
    }
}
