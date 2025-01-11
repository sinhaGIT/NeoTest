//
//  BottomSheetViewModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

/// A view model responsible for managing the logic and data required by the BottomSheet view.
/// This class adheres to the `ObservableObject` protocol, allowing SwiftUI views to bind to its properties
/// and automatically update the UI when changes occur.
///
/// The primary role of this view model is to process a list of car models and determine the top three
/// most frequently occurring characters across the model names. It also provides formatted data for
/// display in the BottomSheet view.

import Foundation

class BottomSheetViewModel: ObservableObject {
    
    /// An array of car sub-models used as the primary data source.
    var carModels: [CarSubModel]
    
    /// A published property containing the top three most frequently occurring characters
    /// across all car model names. Changes to this property will trigger UI updates in SwiftUI views.
    @Published var top3CharacterCount: [CharacterCountModel] = []
    
    /// Initializes the view model with an array of car sub-models and calculates the top three characters.
    /// - Parameter carModels: An array of `CarSubModel` used to compute character counts.
    init(carModels: [CarSubModel]) {
        self.carModels = carModels
        fetchTopThreeCharacter()
    }
    
    /// Fetches the top three most frequently occurring characters in car model names
    /// and assigns the result to the `top3CharacterCount` property.
    func fetchTopThreeCharacter() {
        self.top3CharacterCount = self.getTopThreeCharacterCount(self.carModels.compactMap({$0.modelName}))
    }
}


extension BottomSheetViewModel {
    
    /// Computes the top three most frequently occurring characters in a list of strings.
    /// - Parameter items: An array of strings from which to calculate character counts.
    /// - Returns: An array of `CharacterCountModel` objects representing the top three characters and their counts.
    /// 
    func getTopThreeCharacterCount(_ items: [String]) -> [CharacterCountModel] {
        var charCounts: [(key: Character, value: Int)] = []
        var charCountDict: [Character: Int] = [:]
        
        // Count the frequency of each character, ignoring spaces and case.
        for item in items {
            for char in item.replacingOccurrences(of: " ", with: "").lowercased() {
                charCountDict[char] = (charCountDict[char] ?? 0) + 1
            }
        }
        
        // Sort the characters by count in descending order and take the top three.
        charCounts = Array(charCountDict.sorted { $0.value > $1.value }.prefix(3))
                
        // Convert the sorted key-value pairs into an array of CharacterCountModel
        return charCounts.map { CharacterCountModel(key: $0.key, value: $0.value) }
    }
}
