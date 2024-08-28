//
//  Enums.swift
//  Dessert List
//
//  Created by Dylan Ierugan on 8/24/24.
//

import Foundation

enum DetailCodingKey: String {
    case StrMeal = "strMeal"
    case StrInstructions = "strInstructions"
    case StrMealThumb = "strMealThumb"
    case StrIngredient = "strIngredient"
    case StrMeasure = "strMeasure"
}

enum DetailViewText: String {
    case Instructions = "Instructions"
    case IngredientsMeasurements = "Ingredients & Measurements"
}

enum ErrorMessage: String {
    case ReturnBack = "Return back"
    case InvalidURL = "Invalid API URL"
    case InvalidResponse = "Invalid response from API"
    case InvalidData = "Invalid data from API"
    case UnknownError = "Unknown error"
    case DessertDetialError = "Error loading dessert details"
}

enum Icon: String {
    case ChevronForward = "chevron.forward"
}

enum LinkEnum: String {
    case Desserts = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    case DessertDetail = "https://themealdb.com/api/json/v1/1/lookup.php?i="
}

enum TitleString: String {
    case Desserts = "Desserts"
}
