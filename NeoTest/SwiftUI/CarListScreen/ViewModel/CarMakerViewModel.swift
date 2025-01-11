//
//  CarMakerViewModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//
//  The `CarMakerViewModel` is the ViewModel responsible for managing the state and business logic
//  of the Car Maker screen. It adheres to the `ObservableObject` protocol, allowing the UI to
//  automatically reflect changes to its published properties.
//
//  This class handles fetching car maker data from a JSON file, filtering car models by brand
//  and search text, and maintaining the state of the currently selected car maker.
//

import Foundation

/// A ViewModel responsible for managing car maker data and business logic for the Car Maker screen.
final class CarMakerViewModel: ObservableObject {
    
    // MARK: - Published Properties
        
    /// The list of car makers fetched from the JSON file.
    /// This property is published so that SwiftUI views update automatically when the data changes.
    @Published var carMakers: [CarMakerModel] = []
    
    /// The filtered list of car models based on the selected brand and search text.
    /// This property is published to update the UI with the filtered results.
    @Published var filterCarModels: [CarSubModel] = []
    
    /// The current search text entered by the user.
    /// Updates to this property trigger the filtering logic for car models.
    @Published var searchText: String = "" {
        didSet {
            filter(by: searchText, for: selectedBrandIndex)
        }
    }
    
    // MARK: - Private Properties
        
    /// The index of the currently selected car brand in the `carMakers` array.
    /// This is used to filter the car models associated with the selected brand.
    private var selectedBrandIndex: Int = 0
    
    // MARK: - Initialization
    
    /// Initializes the `CarMakerViewModel` and fetches the initial list of car makers from the JSON file.
    init() {
        fetchCarMakers()
    }
    
    // MARK: - Private Methods
    
    /// Fetches the list of car makers from a local JSON file and decodes them into `CarMakerModel` objects.
    ///
    /// - This method looks for a JSON file specified by the constants in `Constants.ResourceNames` and
    ///   `Constants.FileExtensionNames`. If the file is found and decoding succeeds, the car maker data
    ///   is stored in the `carMakers` property.
    ///
    private func fetchCarMakers() {
        guard let url = Bundle.main.url(forResource: Constants.ResourceNames.carModels, withExtension: Constants.FileExtensionNames.json) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            if let decodedResponse = JSONDecoderService.decode([CarMakerModel].self, from: data) {
                carMakers = decodedResponse
            }
        } catch {
        }
    }
    
    /// Filters the car models based on the provided search key and selected brand.
    ///
    /// - Parameters:
    ///   - searchKey: The search text entered by the user.
    ///   - brandIndex: The index of the selected brand in the `carMakers` array.
    ///
    /// - If the search key is empty, all car models for the selected brand are included.
    /// - If the search key is non-empty, only models whose names contain the search key (case-insensitive)
    ///   are included in the filtered results.
    ///
    private func filter(by searchKey: String, for brandIndex: Int) {
        let carModels = carMakers[brandIndex].models
        
        if searchKey.isEmpty {
            filterCarModels = carModels
        }else {
            let filteredModels = carModels.filter { model in
                return model.modelName.lowercased().contains(searchKey.lowercased())
            }
            
            filterCarModels = filteredModels
        }
    }
    
    // MARK: - Public Methods
    
    /// Updates the filtered car models based on the selected brand.
    ///
    /// - Parameter index: The index of the selected car brand in the `carMakers` array.
    ///
    /// - This method resets the search text and updates the `filterCarModels` property
    ///   to include all models for the selected brand.
    ///
    func updateFilterCarModel(fromIndex index: Int) {
        searchText = ""
        selectedBrandIndex = index
        filterCarModels = carMakers[index].models
    }
}
