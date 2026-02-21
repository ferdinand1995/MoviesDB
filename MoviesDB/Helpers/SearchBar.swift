//
//
//  MoviesDB
//
//
//

import Foundation
import SwiftUI

public struct SearchBar: View {
    var placeHolderText: String
    var iconImage: Image
    var cancelIcon: Image = Image(systemName: "clear")
    var borderColor = Color.gray
    var cornerRadius: CGFloat
    var height: CGFloat
    
    @Binding var searchText: String
    @State var inputText: String
    @FocusState private var isFocusedInternal: Bool
    private var externalFocusBinding: Binding<Bool>?
    
    public init(
        placeHolderText: String,
        iconImage: Image = Image(systemName: "magnifyingglass"),
        borderColor: Color = Color.gray,
        searchText: Binding<String>,
        cornerRadius: CGFloat = 8,
        height: CGFloat = .Spacing.xLarge, isFocused: Binding<Bool>? = nil)
    {
        self.placeHolderText = placeHolderText
        self.iconImage = iconImage
        self.borderColor = borderColor
        _searchText = searchText
        _inputText = State(initialValue: searchText.wrappedValue)
        self.cornerRadius = cornerRadius
        self.height = height
        self.externalFocusBinding = isFocused
    }
    
    public var body: some View {
        HStack {
            TextField(placeHolderText, text: $inputText)
                .onChange(of: inputText) { _, _ in
                    searchText = inputText
                }
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .focused($isFocusedInternal)
                .onChange(of: isFocusedInternal) { _, newValue in
                    externalFocusBinding?.wrappedValue = newValue
                }
                .onChange(of: externalFocusBinding?.wrappedValue) { _, newValue in
                    isFocusedInternal = newValue ?? false
                }
            
            if !inputText.isEmpty {
                Button(action: {
                    searchText = ""
                    inputText = ""
                }) {
                    cancelIcon.grayscale(1)
                }
            }
            
            if inputText.isEmpty {
                iconImage
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: 1)
                .frame(height: height)
        )
    }
}
