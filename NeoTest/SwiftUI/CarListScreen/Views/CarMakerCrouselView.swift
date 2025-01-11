//
//  CarMakeCrouselView.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

import SwiftUI

struct CarMakerCrouselView: View {
    
    /// An array of car maker models used as the primary data source.
    var carMakers: [CarMakerModel]
    
    /// closure property called when page changes in crousel view to update parent view
    let onPageChange: (Int) -> Void
    
    /// The car maker crousel view that manages the state and behavior for the crsouel view page indicator.
    /// Declared as `@StateObject` to ensure that this instance is owned and managed by the SwiftUI view.
    /// This property handles page indicator current index, ensuring the parent view updates whenever
    /// relevant properties in the `CarMakerCrouselView` change.
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(Array(carMakers.enumerated()), id: \.offset) { (index, carMaker) in
                    VStack {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 180)
                            .overlay(
                                Image(uiImage: UIImage(named: carMaker.imageUrl) ?? UIImage())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                            )
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                }
            }
            .frame(height: 200)
            .background(Color.white)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: currentPage) { newPage in
                onPageChange(newPage)
            }
            
            // Custom Page Indicator
            HStack {
                ForEach(0..<carMakers.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.blue : Color.gray) // Blue for active page, gray for others
                        .frame(width: 7, height: 7)
                        .padding(1)
                }
            }
            .padding(.top, 0)
        }
    }
}

#Preview {
    CarMakerCrouselView(carMakers: [CarMakerModel(id: "\(UUID())", brandName: "Tata", manufacturer: "Tata", imageUrl: "Tata", models: [])]) { newPage in
        
    }
}
