//
//  BottomSheetView.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

import SwiftUI

struct BottomSheetView: View {
    @StateObject var viewModel: BottomSheetViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("List Statistics")
                .font(.title)
                .padding()
            
            Divider()
            
            VStack(alignment: .leading) {
                
                Text("Total Items: \($viewModel.carModels.count)")
                    .padding(.vertical, 4)
                
                if !$viewModel.top3CharacterCount.isEmpty {
                    Text("Top 3 Characters:")
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
    BottomSheetView(viewModel: BottomSheetViewModel(carModels: [CarSubModel(id: "1", modelName: "Nano", imageUrl: "", price: "120.0")]))
}
