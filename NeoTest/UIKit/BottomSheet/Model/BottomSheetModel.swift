//
//  BottomSheetModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 06/01/25.
//

//  This model represents a character count model and its associated details.
//  It is providing a structured
//  representation of car list containing character and its count information.

import Foundation

struct CharacterCountModel {
    // MARK: - Properties
    
    /// The unique identifier of the car brand.
    let id = UUID()  // Make the structure identifiable
    
    /// The key for storing character.
    var key: Character
    
    /// The count of each character
    var value: Int
}
