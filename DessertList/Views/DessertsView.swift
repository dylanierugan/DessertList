//
//  DessertsView.swift
//  Dessert List
//
//  Created by Dylan Ierugan on 8/23/24.
//

import SwiftUI

struct DessertsView: View {
    
    // MARK: - Private Variables
    
    @StateObject private var dessertViewModel = DessertViewModel(desserts: [])
    
    // MARK: - View
    
    var body: some View {
        
        NavigationView {
            VStack {
                if dessertViewModel.dessertsLoading {
                    ProgressView()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(dessertViewModel.desserts, id: \.idMeal) { dessert in
                            NavigationLink {
                                DessertDetailView(dessertViewModel: dessertViewModel,
                                                  dessert: dessert,
                                                  networkManager: dessertViewModel.networkManager)
                            } label: {
                                DessertCardView(dessert: dessert)
                            }
                        }
                    }
                }
            }
            .navigationTitle(TitleString.Desserts.rawValue)
            .task { await dessertViewModel.fetchDesserts() }
        }
        .accentColor(.primary)
    }
}
