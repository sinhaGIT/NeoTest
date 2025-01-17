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

struct SearchBarView: View {
    @Binding var searchText: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 5)
                    TextField(Constants.PlaceholderNames.search, text: $searchText)
                        .padding(5)
                        .onTapGesture {
                            self.isEditing = true
                        }
                }
                .background(.white)
                .cornerRadius(10.0)
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.searchText = ""
                        // Dismiss keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("cancel")
                            .font(Font.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 140/255, green: 161/255, blue: 173/255))
                    }
                    .padding(.trailing, 10)
                }
            }
            .padding(10)
        }
    }
}
