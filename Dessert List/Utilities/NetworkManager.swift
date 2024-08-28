//
//  NetworkManager.swift
//  Dessert List
//
//  Created by Dylan Ierugan on 8/24/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct NetworkManager: Codable {
    
    func fetchDesserts() async throws -> [Dessert] {
        guard let url = URL(string: LinkEnum.Desserts.rawValue) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let dessertResponse = try JSONDecoder().decode(DessertResponse.self, from: data)
            return dessertResponse.meals
        } catch {
            throw APIError.invalidData
        }
    }
    
    func fetchMealDetail(by idMeal: String) async throws -> DessertDetail {
        guard let url = URL(string: "\(LinkEnum.DessertDetail.rawValue)\(idMeal)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let dessertDetailResponse = try JSONDecoder().decode(DessertDetailResponse.self, from: data)
            guard let dessertDetail = dessertDetailResponse.meals.first else {
                throw APIError.invalidData
            }
            return dessertDetail
        } catch {
            throw APIError.invalidData
        }
    }
    
}
