//
//  BottomSheetViewModel.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

import Foundation

class BottomSheetViewModel: ObservableObject {
    
    var carModels: [CarSubModel]
    @Published var top3CharacterCount: [CharacterCountModel] = []
    
    init(carModels: [CarSubModel]) {
        self.carModels = carModels
        fetchTopThreeCharacter()
    }
    
    func fetchTopThreeCharacter() {
        self.top3CharacterCount = self.getTopThreeCharacterCount(self.carModels.compactMap({$0.modelName}))
    }
    
    func getFormattedText(forRow row: Int) -> String {
        let characterMap = top3CharacterCount[row]
        return "\(characterMap.key) = \(characterMap.value)"
    }
    
    func getSectionTitle() -> String {
        return "Top 3 Characters:"
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
