//
//  CarModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//
//  This model represents a car brand and its associated details.
//  It is used for decoding JSON data and providing a structured
//  representation of car brand information.
//

import Foundation

struct CarBrandModel : Decodable {
    // MARK: - Properties
    
    /// The unique identifier of the car brand.
    let id : String
    
    /// The name of the car brand (e.g., "Toyota", "BMW").
    let brandName : String
    
    /// A manufacturer name of the car brand.
    let manufacturer : String
    
    /// The URL of the logo image for the car brand.
    let imageUrl : String
    
    /// A list of car models associated with the car brand.
    var models : [CarModel]
}


struct CarModel : Decodable {
    // MARK: - Properties
    
    /// The unique identifier of the car model.
    let id : String
    
    /// The name of the car model (e.g., "Nexon", "Punch").
    let modelName : String
    
    /// The URL of the logo image for the car model.
    let imageUrl : String
    
    /// The price for the car model.
    let price : String
}
