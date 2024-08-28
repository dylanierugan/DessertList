//
//  DessertDetail.swift
//  Dessert List
//
//  Created by Dylan Ierugan on 8/24/24.
//

import Foundation

struct DessertDetailResponse: Decodable {
    let meals: [DessertDetail]
}

struct DessertDetail: Decodable {
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    var ingredients: [String]
    var measurements: [String]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        if let strMealKey = DynamicCodingKeys(stringValue: DetailCodingKey.StrMeal.rawValue) {
            strMeal = try container.decode(String.self, forKey: strMealKey)
        } else {
            strMeal = ""
            // - Handle error
        }
        
        if let strInstructionsKey = DynamicCodingKeys(stringValue: DetailCodingKey.StrInstructions.rawValue) {
            strInstructions = try container.decode(String.self, forKey: strInstructionsKey)
        } else {
            strInstructions = ""
            // - Handle error
        }
        
        if let strMealThumbKey = DynamicCodingKeys(stringValue: DetailCodingKey.StrMealThumb.rawValue) {
            strMealThumb = try container.decode(String.self, forKey: strMealThumbKey)
        } else {
            strMealThumb = ""
            // - Handle error
        }
        
        ingredients = try (1...20).compactMap { index in
            guard let key = DynamicCodingKeys(stringValue: "\(DetailCodingKey.StrIngredient.rawValue)\(index)") else { return nil }
            return try container.decodeIfPresent(String.self, forKey: key)?
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }.filter { !$0.isEmpty }
        
        measurements = try (1...20).compactMap { index in
            guard let key = DynamicCodingKeys(stringValue: "\(DetailCodingKey.StrMeasure.rawValue)\(index)") else { return nil }
            return try container.decodeIfPresent(String.self, forKey: key)?
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }.filter { !$0.isEmpty }
    }
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int? { nil }
        init?(intValue: Int) { nil }
    }
}
