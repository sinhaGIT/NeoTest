//
//  StickeySearchBar.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

import SwiftUI

struct StickySearchBar: View {
    
    /// A binding property that holds the current search text entered by the user.
    /// This property is passed from a parent view, allowing two-way data flow
    /// between the parent and this view. Updates to this property will trigger
    /// filtering or search-related actions in the parent view.
    @Binding var searchText: String
    
    /// A focus state property that tracks whether the search text field is currently focused.
    /// When `true`, the search field is active and ready for input; when `false`, it is unfocused.
    /// This property is used to programmatically control and monitor the focus state of the search field.
    @FocusState private var isSearchFieldFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: Constants.IconNames.magnifyingglass)
                .foregroundColor(.gray)
            TextField(Constants.PlaceholderNames.search, text: $searchText)
                .padding(7)
                .focused($isSearchFieldFocused)
                .autocorrectionDisabled(true)
                .onChange(of: searchText) { _ in
                    isSearchFieldFocused = true
                }
        }
        .padding(.horizontal)
        .background(Color.clear)
    }
}
