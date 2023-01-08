//
//  CardView.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import SwiftUI

struct CardView: View {
    @Binding var isTapped: Bool
    let card: Card
    var body: some View {
        VStack {
            Text(isTapped ? card.definition : card.term)
        }
        .frame(width: 300, height: 400)
        .background (isTapped ? .blue : .orange)
        .cornerRadius(20)
        .onTapGesture { isTapped.toggle() }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(isTapped: .constant(false), card: Card.sampleCard)
            .environmentObject(Stack(dataService: MockDataService()))
    }
}

