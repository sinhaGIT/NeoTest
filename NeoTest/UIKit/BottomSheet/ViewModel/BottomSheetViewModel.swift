//
//  BottomSheetViewModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 29/12/24.
//

import Foundation

class BottomSheetViewModel {
    
    private var carModels: [CarModel]
    private var top3CharacterCount: [CharacterCountModel] = []
    
    init(carModels: [CarModel]) {
        self.carModels = carModels
        self.top3CharacterCount = self.getTopThreeCharacterCount(self.carModels.compactMap({$0.modelName}))
    }
    
    func numberOfRows() -> Int {
        return top3CharacterCount.count
    }
    
    func getFormattedText(forRow row: Int) -> String {
        let characterMap = top3CharacterCount[row]
        return "\(characterMap.key) = \(characterMap.value)"
    }
    
    func getTotalItemText() -> String {
        return "Total items: \(carModels.count)"
    }
    
    func getSectionTitle() -> String {
        return "Top \(top3CharacterCount.count) Characters:"
    }
}


extension BottomSheetViewModel {
    func getTopThreeCharacterCount(_ items: [String]) -> [CharacterCountModel] {
        var charCounts: [(key: Character, value: Int)] = []
        var charCountDict: [Character: Int] = [:]
        for item in items {
            for char in item.replacingOccurrences(of: " ", with: "").lowercased() {
                charCountDict[char] = (charCountDict[char] ?? 0) + 1
            }
        }
        charCounts = Array(charCountDict.sorted { $0.value > $1.value }.prefix(3))
        
        // Convert the sorted key-value pairs into an array of CharacterCountModel
        return charCounts.map { CharacterCountModel(key: $0.key, value: $0.value) }
    }
}
