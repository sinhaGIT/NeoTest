//
//  CarListViewModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//
//  This view model is responsible for managing the data and business logic
//  for the CarListViewController. It provides the necessary data to the view,
//  handles interactions, and ensures separation of concerns by keeping
//  the view controller free from business logic.

import Foundation

final class CarListViewModel {
    
    /// The list of car brands to be displayed in the view.
    private var carBrands: [CarBrandModel] = []
    /// For keeping last filtered car list.
    private var carModelsBeforFilter: [CarModel] = []
    /// The search text entered by user.
    private var currentSearchText = ""
    
    init() {
        fetchCarMakers()
    }
    
    /// Method for locating resource file as well as convert data to models using json decoder service class.
    ///
    ///
    func fetchCarMakers() {
        guard let url = Bundle.main.url(forResource: Constants.ResourceNames.carModels, withExtension: Constants.FileExtensionNames.json) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            if let decodedResponse = JSONDecoderService.decode([CarBrandModel].self, from: data) {
                carBrands = decodedResponse
            }
        } catch {
        }
    }
        
    /// Method for getting number of rows to be displayed for particular car brand.
    ///
    /// - Parameters:
    ///   - index: this is index of current car brand.
    /// - Returns: Number of car model available for particular car brand.
    ///
    func numberOfModelForBrand(at index: Int) -> Int {
        return carBrands[index].models.count
    }
    
    /// Method for getting car model for particular car brand.
    ///
    /// - Parameters:
    ///   - indexPath: we get current brand from section and particular car model for particular row.
    /// - Returns: Car Model for passed indexPath.
    ///
    func getCarModel(at indexPath: IndexPath) -> CarModel {
        return carBrands[indexPath.section].models[indexPath.row]
    }
    
    /// Method for getting all car model for passed index i.e car brand. For display data in bottom sheet
    ///
    /// - Parameters:
    ///   - indexPath: we get current brand from section and particular car model for particular row.
    /// - Returns: Array of Car Model for passed index i.e car brand..
    ///
    func getAllCarModel(forBrand index: Int) -> [CarModel] {
        return carBrands[index].models
    }
    
    // This method simply return current search text fed by user.
    func getSearchText() -> String {
        return currentSearchText
    }
    
    /// Method for clearing search and put back original data
    ///
    /// - Parameters:
    ///   - brandIndex: index of current brand which is displaying to user
    ///
    func clearSearch(for brandIndex: Int) {
        currentSearchText = ""
        if !carModelsBeforFilter.isEmpty {
            self.carBrands[brandIndex].models = carModelsBeforFilter
        }
        carModelsBeforFilter = []
    }
    
    /// Method for getting view model header view.
    ///
    /// - Returns: Fully initialized instance of CarBrandHeaderViewModel class.
    ///
    func getHeaderCellVM() -> CarBrandHeaderViewModel {
        let headerVM = CarBrandHeaderViewModel(carBrands: carBrands)
        return headerVM
    }
}

//  This extension provides implementation of filter car list from whole dataset
//
extension CarListViewModel {
    /// Method for filtering data as per search text and updating models
    ///
    /// - Parameters:
    ///   - searchKey: this is actual query user typed in search box.
    ///   - brandIndex: index of current brand which is displaying to user
    ///
    func filter(by searchKey: String, for brandIndex: Int) {
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
