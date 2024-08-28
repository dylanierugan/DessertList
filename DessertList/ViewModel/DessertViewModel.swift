//
//  DessertViewModel.swift
//  Dessert List
//
//  Created by Dylan Ierugan on 8/24/24.
//

import Foundation

class DessertViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var desserts: [Dessert]
    @Published var dessertDict: [String: DessertDetail]
    
    @Published var dessertsLoading = true
    @Published var dessertDetailLoading = true
    
    @Published var dessertDetail: DessertDetail?
    
    var networkManager = NetworkManager()
    
    // MARK: - Init
    
    init(desserts: [Dessert]) {
        self.desserts = desserts.sorted {
            $0.strMeal.lowercased() < $1.strMeal.lowercased()
        }
        self.dessertDict = [:]
    }
    
    func fetchDesserts() async {
        do {
            let fetchedDesserts = try await networkManager.fetchDesserts()
            DispatchQueue.main.async {
                self.desserts = fetchedDesserts.sorted {
                    $0.strMeal.lowercased() < $1.strMeal.lowercased()
                }
                self.dessertsLoading = false
            }
        } catch {
            // - Handle error
            DispatchQueue.main.async {
                self.dessertsLoading = false
            }
        }
    }
    
    func getDessertDetail(dessert: Dessert) async {
        if let dessertDetail = dessertDict[dessert.idMeal] {
            DispatchQueue.main.async {
                self.dessertDetail = dessertDetail
                self.dessertDetailLoading = false
            }
        } else {
            do {
                let fetchedDetail = try await networkManager.fetchMealDetail(by: dessert.idMeal)
                DispatchQueue.main.async {
                    self.dessertDetail = fetchedDetail
                    self.dessertDict[dessert.idMeal] = fetchedDetail
                    self.dessertDetailLoading = false
                }
            } catch {
                // - Handle error
                DispatchQueue.main.async {
                    self.dessertDetailLoading = false
                }
            }
        }
    }
}
