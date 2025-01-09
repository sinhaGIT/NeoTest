//
//  CarBrandHeaderViewModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 09/01/25.
//
//  This view model is responsible for managing the data and business logic
//  for the Header View Used in Car List View Controller. It provides the necessary data to the cell,
//  handles interactions, and ensures separation of concerns by keeping
//  the header view free from business logic.

import Foundation


final class CarBrandHeaderViewModel {
    
    /// The list of car brands to be displayed in the header view.
    private var carBrands: [CarBrandModel]
    
    init(carBrands: [CarBrandModel]) {
        self.carBrands = carBrands
    }
    
    func numberOfCarBrands() -> Int {
        return carBrands.count
    }
    
    func getBrandImageName(at indexPath: IndexPath) -> String {
        return carBrands[indexPath.row].imageUrl
    }
}
