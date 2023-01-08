//
//  SetView.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import SwiftUI

struct SetView: View {
    let set: Set
    var body: some View {
        VStack {
            
            Text(set.setName)
                .font(.title.weight(.bold))
                .padding(.vertical)
            
            Text(set.cards.count == 0 ? "\(set.cards.count) card" : "\(set.cards.count) cards")

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

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
//        SetView(set: Set.sampleSet)
        HomeView(selectedTab: .constant(.house))
            .environmentObject(Stack(dataService: MockDataService()))
    }
}
