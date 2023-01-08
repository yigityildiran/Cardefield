//
//  TopBarButton.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import SwiftUI

struct TopBarButton: View {
    @Environment(\.dismiss) var dismiss
    let text: String
    var body: some View {
        HStack {
            Image(systemName: "arrow.left.circle")
                .font(.title)
                .foregroundColor(.black)
                .frame(maxWidth: 30)
                .onTapGesture { dismiss() }
            
            Spacer()
            
            Text(text)
                .font(.title)
            
            Spacer()
            
            Image(systemName: "arrow.left.circle")
                .font(.title)
                .foregroundColor(.black)
                .frame(maxWidth: 30)
                .opacity(0)
            
        }
        .padding(.vertical)
    }
}

struct TopBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TopBarButton(text: "Biology")
    }
}
