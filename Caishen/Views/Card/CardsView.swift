//
//  CardsView.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import SwiftUI

struct CardsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: Stack
    @State var isTapped: Bool = false
    @State var set: Set
    var body: some View {
        VStack {
            TopBarButton(text: set.setName)
            Divider()
            Spacer()
            
            if !set.cards.isEmpty {
                ZStack {
                    ForEach(Array(set.cards.enumerated()), id: \.element) { index, card in
                        CardView(isTapped: $isTapped, card: card)
                            .zIndex(-Double(index))
                        
                    }
                }
            } else {
                Button {  dismiss() }
                label: {
                    Text("Congratulations - you've done it all")
                        .foregroundColor(.orange)
                        .font(.title)
                }

                
            }
            
            
            Spacer()
            if !set.cards.isEmpty { bottomButtons  }
        }
        .padding(.horizontal)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            if vm.recentlyUsed.count > 2 { vm.recentlyUsed.remove(at: 0) }
            if !vm.recentlyUsed.contains(set) { vm.recentlyUsed.append(set)}
            vm.isSearch = false
        }
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView(set: .sampleSet)
            .environmentObject(Stack(dataService: MockDataService()))
    }
}


extension CardsView {
    // MARK: Views
    var bottomButtons: some View {
        HStack {
            Spacer()
            
            Button { lastCard() }
            label: { Image(systemName: "arrow.left.circle") }
            
            Spacer()
            
            Button { correct() }
            label: {
            Image(systemName: "checkmark")
                .foregroundColor(.green)
                .padding()
                .background {
                    Circle()
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                }
        }
            
            Spacer()
            
            Button { nextCard() }
            label: { Image(systemName: "arrow.right.circle") }
            
            
            Spacer()
        }
        .font(.largeTitle)
        .foregroundColor(.orange)
    }
    
    
    
    // MARK: Functions
    func lastCard() {
        guard let card = set.cards.last else { return }
        set.cards.bringToFront(item: card)
        isTapped = false
    }
    
    func nextCard() {
        guard let card = set.cards.first else { return }
        set.cards.sendToBack(item: card)
        isTapped = false
    }
    
    func correct() {
        set.cards.remove(at: 0)
    }
}
