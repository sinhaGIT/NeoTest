//
//  CarMakeCrouselView.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

import SwiftUI

struct CarMakerCrouselView: View {
    @ObservedObject var viewModel: CarMakerViewModel
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(Array(viewModel.carMakers.enumerated()), id: \.offset) { (index, carMaker) in
                    VStack {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 180)
                            .overlay(
                                Image(uiImage: UIImage(named: carMaker.imageUrl)!)
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
            .onAppear {
                viewModel.fetchCarMakers()
            }
            .frame(height: 200)
            .background(Color.white)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: currentPage) { newPage in
                viewModel.updateFilterCarModel(fromIndex: newPage)
            }
            
            // Custom Page Indicator
            HStack {
                ForEach(0..<viewModel.carMakers.count, id: \.self) { index in
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
    CarMakerCrouselView(viewModel: CarMakerViewModel())
}
