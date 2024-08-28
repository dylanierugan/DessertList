//
//  DessertDetailView.swift
//  Dessert List
//
//  Created by Dylan Ierugan on 8/24/24.
//

import SwiftUI

struct DessertDetailView: View {
    
    // MARK: - Passed Variables
    
    @ObservedObject var dessertViewModel: DessertViewModel
    
    var dessert: Dessert
    var networkManager: NetworkManager
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            VStack {
                if dessertViewModel.dessertDetailLoading {
                    ProgressView()
                } else {
                    if let dessertDetail = dessertViewModel.dessertDetail {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 32) {
                                DessertTitleView(title: dessertDetail.strMeal)
                                DessertInstructionsView(instructions: dessertDetail.strInstructions)
                                DessertIngredientMeasurementsView(dessertDetail: dessertDetail)
                            }
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 16)
                        }
                    } else {
                        Text(ErrorMessage.DessertDetialError.rawValue)
                            .foregroundStyle(.primary)
                            .font(.system(.caption, design: .rounded, weight: .bold))
                    } 
                }
            }
            .task { await dessertViewModel.getDessertDetail(dessert: dessert) }
            .onDisappear { dessertViewModel.dessertDetailLoading = true }
        }
    }
}


// MARK: - Title
struct DessertTitleView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.system(.title, design: .rounded, weight: .bold))
    }
}

// MARK: - Instructions
struct DessertInstructionsView: View {
    var instructions: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(DetailViewText.Instructions.rawValue)
                .font(.system(.body, design: .rounded, weight: .bold))
            Text(instructions)
                .font(.system(.caption, design: .rounded, weight: .regular))
                .multilineTextAlignment(.leading)
        }
    }
}

// MARK: - Passed Ingredients/Measurements
struct DessertIngredientMeasurementsView: View {
    var dessertDetail: DessertDetail
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(DetailViewText.IngredientsMeasurements.rawValue)
                .font(.system(.body, design: .rounded, weight: .bold))
            ForEach(Array(dessertDetail.ingredients.enumerated()), id: \.element) { index, ingredient in
                HStack {
                    Text("\(index + 1). \(ingredient) - \(dessertDetail.measurements[index])")
                }
                .font(.system(.caption, design: .rounded, weight: .regular))
                .multilineTextAlignment(.leading)
            }
        }
    }
}
