//
//  CarMakersView.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

import SwiftUI

struct CarMakersView: View {
    
    /// The view model that manages the state and behavior for the CarMakers view.
    /// Declared as `@StateObject` to ensure that this instance is owned and managed by the SwiftUI view.
    /// This property handles data binding between the view and the logic, ensuring the view updates whenever
    /// relevant properties in the `CarMakersView` change.
    @StateObject private var viewModel: CarMakerViewModel = CarMakerViewModel()
    
    /// A state property that controls the visibility of the bottom sheet.
    /// When `true`, the bottom sheet is displayed; when `false`, it is hidden.
    /// This property is private to the current view and is used to toggle
    /// the bottom sheet's presentation in response to user interactions.
    @State private var showBottomSheet = false
    
    var body: some View {
        ZStack {
            List {
                Section {
                    // Carousel Section
                    CarMakerCrouselView(carMakers: viewModel.carMakers) { newPage in
                        viewModel.updateFilterCarModel(fromIndex: newPage)
                    }
                        .listRowSeparator(.hidden)
                }
                .background(Color.white)
                
                // List Section
                Section(header:
                            StickySearchBar(searchText: $viewModel.searchText)
                    .frame(height: 38)
                    .background(Color(red: 167/255, green: 167/255, blue: 167/255))
                    .cornerRadius(4.0)
                    .padding(.bottom, 16)
                        
                ) {
                    ForEach(viewModel.filterCarModels, id: \.id) { item in
                        CarListRowView(carModel: item)
                            .frame(height: 72.0)
                            .listRowSeparator(.hidden)
                            .background(Color(red: 204/255, green: 232/255, blue: 225/255))
                            .cornerRadius(12.0)
                            .padding(.vertical, -7)
                    }
                }
            }
            .padding(.top, getStatusBarHeight())
            .background(Color.white)
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .onAppear {
                viewModel.updateFilterCarModel(fromIndex: 0)
            }
            
            // Floating Button
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showBottomSheet.toggle()
                    }) {
                        Image(systemName: Constants.IconNames.ellipsis)
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(Color(UIColor(red: 0, green: 117.0/255.0, blue: 227.0/255.0, alpha: 1.0)))
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
                    }
                    .padding()
                    .sheet(isPresented: $showBottomSheet) {
                        let vm = BottomSheetViewModel(carModels: viewModel.filterCarModels)
                        BottomSheetView(viewModel: vm)
                    }
                }
            }
        }
    }
}

// Function to calculate status bar height excluding navigation bar
    private func getStatusBarHeight() -> CGFloat {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.delegate as? SceneDelegate {
                let safeAreaTop = window.window?.safeAreaInsets.top ?? 0
                let navigationBarHeight = UINavigationController().navigationBar.frame.height
                return safeAreaTop - navigationBarHeight
            }
        }
        return 20.0
    }

#Preview {
    CarMakersView()
}
