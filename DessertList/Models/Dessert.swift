//
//  Dessert.swift
//  Dessert List
//
//  Created by Dylan Ierugan on 8/23/24.
//

import Foundation

struct DessertResponse: Codable {
    let meals: [Dessert]
}

struct Dessert: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
