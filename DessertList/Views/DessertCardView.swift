//
//  DessertCardView.swift
//  Dessert List
//
//  Created by Dylan Ierugan on 8/25/24.
//

import SwiftUI

struct DessertCardView: View {
    
    var dessert: Dessert
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: dessert.strMealThumb)) { image in
                image.resizable()
                    .cornerRadius(12)
            } placeholder: {
                ProgressView()
                    .controlSize(.small)
            }
            .frame(width: 100, height: 100)
            Text(dessert.strMeal)
                .foregroundColor(.primary)
                .font(.system(.body, design: .rounded, weight: .bold))
                .multilineTextAlignment(.leading)
            Spacer()
            Image(systemName: Icon.ChevronForward.rawValue)
                .foregroundColor(.secondary)
                .bold()
        }
        .padding(.horizontal, 16)
    }
}

