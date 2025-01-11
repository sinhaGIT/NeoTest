//
//  CarMakerModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//
//  This file defines the data models for representing car makers and their associated sub-models.
//  These models are used for decoding JSON data and providing a structured representation of car manufacturers and their details.
//  The models conform to `Identifiable` to support SwiftUI lists and `Decodable` for JSON decoding.
//

import Foundation

/// A model representing a car maker and its associated details.
struct CarMakerModel: Identifiable, Decodable {
    
    /// The unique identifier for the car maker.
    let id: String
    
    /// The name of the car brand (e.g., "Toyota", "BMW").
    let brandName: String
    
    /// The name of the manufacturer or company producing the car brand.
    let manufacturer: String
    
    /// The URL for the car maker's logo or image.
    let imageUrl: String
    
    /// A list of car sub-models associated with the car maker.
    var models: [CarSubModel]
}

/// A model representing a specific car sub-model.
struct CarSubModel: Identifiable, Decodable {
    
    /// The unique identifier for the car sub-model.
    let id: String
    
    /// The name of the car model (e.g., "Corolla", "X5").
    let modelName: String
    
    /// The URL for the car model's image.
    let imageUrl: String
    
    /// The price of the car model as a string (e.g., "$30,000").
    let price: String
}
