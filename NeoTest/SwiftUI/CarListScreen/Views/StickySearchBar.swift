//
//  StickeySearchBar.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

import SwiftUI

struct StickySearchBar: View {
    @ObservedObject var viewModel: CarMakerViewModel
    @FocusState private var isSearchFieldFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search", text: $viewModel.searchText)
                .padding(7)
                .focused($isSearchFieldFocused)
                .autocorrectionDisabled(true)
                .onChange(of: viewModel.searchText) { _ in
                                            // Ensure TextField remains focused
                                            isSearchFieldFocused = true
                                        }
        }
        .padding(.horizontal)
        .background(Color.clear)
    }
}
