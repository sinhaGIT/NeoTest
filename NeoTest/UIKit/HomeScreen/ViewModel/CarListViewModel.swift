//
//  CarListViewModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import Foundation

final class CarListViewModel {
    
    private var carBrands: [CarBrandModel] = []
    private var carModelsBeforFilter: [CarModel] = []
    private var currentSearchText = ""
    var isSearchStarted = false
    
    init() {
        fetchCarMakers()
    }
    
    func fetchCarMakers() {
        if let url = Bundle.main.url(forResource: "CarModels", withExtension: "json"), let data = try? Data(contentsOf: url) {
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let decodedResponse = try? decoder.decode([CarBrandModel].self, from: data) {
                carBrands = decodedResponse
            }
        }
    }
    
    func numberOfModelForBrand(at index: Int) -> Int {
        return carBrands[index].models.count
    }
    
    func getCarModel(at indexPath: IndexPath) -> CarModel {
        return carBrands[indexPath.section].models[indexPath.row]
    }
    
    func numberOfCarBrands() -> Int {
        return carBrands.count
    }
    
    func getBrandImageName(at indexPath: IndexPath) -> String {
        return carBrands[indexPath.row].imageUrl
    }
    
    func getAllCarModel(forBrand index: Int) -> [CarModel] {
        return carBrands[index].models
    }
    
    func getSearchText() -> String {
        return currentSearchText
    }
    
    func clearSearch(for brandIndex: Int) {
        currentSearchText = ""
        if !carModelsBeforFilter.isEmpty {
            self.carBrands[brandIndex].models = carModelsBeforFilter
        }
        carModelsBeforFilter = []
    }
}


extension CarListViewModel {
    func filter(by searchKey: String, for brandIndex: Int) {
        isSearchStarted = true
        currentSearchText = searchKey
        if searchKey.isEmpty {
            clearSearch(for: brandIndex)
            return
        }
        
        var carModels = carModelsBeforFilter
        if carModelsBeforFilter.isEmpty {
            carModels = self.carBrands[brandIndex].models
            carModelsBeforFilter = carModels
        }
        let filteredModels = carModels.filter { model in
            return model.modelName.lowercased().contains(searchKey.lowercased())
        }
        self.carBrands[brandIndex].models = filteredModels
    }
}
