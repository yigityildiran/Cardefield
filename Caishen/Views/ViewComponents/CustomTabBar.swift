//
//  CustomTabBar.swift
//  Caishen
//
//  Created by Caishen on 19/12/2022.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue
    }
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                    .font(.title2)
                    .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                    .foregroundColor(selectedTab == tab ? .orange : .black)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            selectedTab = tab
                        }
                    }
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 2)
        
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedTab: .constant(.house))
            .environmentObject(Stack(dataService: MockDataService()))
    }
}


enum Tab: String, CaseIterable {
    case house = "house.fill"
    case plus = "slider.horizontal.2.gobackward"
    case folder = "folder.fill"
}
