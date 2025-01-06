//
//  CarMakerViewModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

import Foundation

final class CarMakerViewModel: ObservableObject {
    @Published var carMakers: [CarMakerModel] = []
    @Published var filterCarModels: [CarSubModel] = []
    @Published var searchText: String = "" {
        didSet {
            filter(by: searchText, for: selectedBrandIndex)
        }
    }
    @Published var currentPageInCraousel: Int = 0
    private var selectedBrandIndex: Int = 0
    
    init() {
    }
    
    func fetchCarMakers() {
        if let url = Bundle.main.url(forResource: "CarModels", withExtension: "json"), let data = try? Data(contentsOf: url) {
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let decodedResponse = try? decoder.decode([CarMakerModel].self, from: data) {
                carMakers = decodedResponse
            }
        }
    }
    
    func updateFilterCarModel(fromIndex index: Int) {
        searchText = ""
        selectedBrandIndex = index
        filterCarModels = carMakers[index].models
    }
    
    func filter(by searchKey: String, for brandIndex: Int) {
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
}
