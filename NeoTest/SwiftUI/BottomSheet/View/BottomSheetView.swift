//
//  BottomSheetView.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

import SwiftUI

struct BottomSheetView: View {
    /// The view model that manages the state and behavior for the BottomSheet view.
    /// Declared as `@StateObject` to ensure that this instance is owned and managed by the SwiftUI view.
    /// This property handles data binding between the view and the logic, ensuring the view updates whenever
    /// relevant properties in the `BottomSheetViewModel` change.
    /// 
    @StateObject var viewModel: BottomSheetViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.NavigationTitles.listStatistics)
                .font(.title)
                .padding()
            
            Divider()
            
            VStack(alignment: .leading) {
                
                Text("Total Items: \($viewModel.carModels.count)")
                    .padding(.vertical, 4)
                
                if !$viewModel.top3CharacterCount.isEmpty {
                    Text("Top \(viewModel.top3CharacterCount.count) Characters:")
                        .padding(.vertical, 4)
                    List(viewModel.top3CharacterCount) { item in
                        HStack {
                            Text("\(item.key) = \(item.value)")
                                .padding(.vertical, 2)
                        }
                        .background(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    BottomSheetView(viewModel: BottomSheetViewModel(carModels: [CarSubModel(id: "1", modelName: "Nexon", imageUrl: "Nexon", price: "12.0")]))
}
