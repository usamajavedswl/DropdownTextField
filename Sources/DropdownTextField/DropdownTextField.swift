//
//  DropdownTextField.swift
//  DropdownTextField
//
//  Created by Mian Usama on 16/09/2025.
//  Copyright © 2025 Usama Javed. All rights reserved.
//
//  Description:
//  A customizable searchable dropdown menu component built with SwiftUI.
//  Supports custom fonts, colors, and dynamic option filtering.
//  Designed and maintained by Usama Javed.
//

import SwiftUI
import Combine

public struct DropdownTextField: View {
    @Binding var searchText: String
    @Binding var isDropdownVisible: Bool
    
    @State private var isOptionSelected: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @FocusState private var isSearchFieldFocused: Bool
    
    private var options: [String]
    private var placeholder: String
    private var addNew: Bool
    private var textColor: Color = .primary
    private var placeholderColor: Color = .gray
    private var accentColor: Color = .blue
    private var successColor: Color = .green
    private var destructiveColor: Color = .red
    private var borderColor: Color? = nil
    private var font: Font = .system(size: 16)
    private var height: CGFloat = 40
    private var cornerRadius: CGFloat = 8
    private var dropdownIcon: Image = Image(systemName: "chevron.down")
    private var noMatchText: String = "No match"
    private var addNewTextFormat: String = "Add %@"
    private var onTap: () -> Void
    
    // MARK: - Init
    public init(
        searchText: Binding<String>,
        isDropdownVisible: Binding<Bool>,
        options: [String],
        placeholder: String,
        addNew: Bool = false,
        textColor: Color = .primary,
        placeholderColor: Color = .gray,
        accentColor: Color = .blue,
        successColor: Color = .green,
        destructiveColor: Color = .red,
        borderColor: Color? = nil,
        font: Font = .system(size: 16),
        height: CGFloat = 40,
        cornerRadius: CGFloat = 8,
        dropdownIcon: Image = Image(systemName: "chevron.down"),
        noMatchText: String = "No match",
        addNewTextFormat: String = "Add %@",
        onTap: @escaping () -> Void
    ){
        self._searchText = searchText
        self._isDropdownVisible = isDropdownVisible
        self.options = options
        self.placeholder = placeholder
        self.addNew = addNew
        self.onTap = onTap
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.accentColor = accentColor
        self.successColor = successColor
        self.destructiveColor = destructiveColor
        self.borderColor = borderColor
        self.font = font
        self.height = height
        self.cornerRadius = cornerRadius
        self.dropdownIcon = dropdownIcon
        self.noMatchText = noMatchText
        self.addNewTextFormat = addNewTextFormat
    }
    
    public var body: some View {
        VStack(spacing: 2){
            HStack(spacing: 0){
                HStack {
                    ZStack(alignment: .leading){
                        if searchText.isEmpty {
                            Text(placeholder)
                                .foregroundColor(placeholderColor.opacity(0.7))
                                .font(font)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                        }
                        TextField("", text: $searchText, onEditingChanged: { isEditing in isDropdownVisible = isEditing
                            if isEditing {
                                isOptionSelected = false
                                onTap()
                                isSearchFieldFocused = true
                            }
                        })
                        .font(font)
                        .tint(accentColor)
                        .foregroundColor(textColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($isSearchFieldFocused)
                        .onTapGesture {
                            if !searchText.isEmpty {
                                searchText = ""
                                isOptionSelected = false
                                isDropdownVisible = true
                                onTap()
                                isSearchFieldFocused = true
                            }
                        }
                        .onSubmit {
                            if let topOption = filteredOptions.first {
                                selectOption(topOption)
                            } else if addNew && !searchText.isEmpty {
                                selectOption(searchText)
                            }
                        }
                    }
                    Button(action: {
                        isDropdownVisible.toggle()
                        isSearchFieldFocused = isDropdownVisible
                    }){
                        dropdownIcon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: height * 0.45, height: height * 0.45)
                            .foregroundColor(borderColor)
                            .rotationEffect(.degrees(isDropdownVisible ? 180 : 0))
                    }
                    .frame(width: 35)
                    .padding(.trailing, 8)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: height)
            .background( RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(computedBorderColor, lineWidth: 1)
            )
            
            if isDropdownVisible {
                ScrollView {
                    LazyVStack(spacing: 0){
                        ForEach(filteredOptions.indices, id: \.self){ index in
                            let option = filteredOptions[index]
                            Button(action: { selectOption(option)}){
                                HStack {
                                    Text(option)
                                        .font(font)
                                        .foregroundColor(index == 0 && !searchText.isEmpty ? .white : textColor)
                                        .padding(.leading, 15)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                .padding(.vertical, 4)
                                .background(index == 0 && !searchText.isEmpty ? accentColor : Color.clear)
                                .cornerRadius(8)
                            }
                        }
                        let trimmedSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                        let allowedCharacters = CharacterSet.alphanumerics
                        let normalizedSearch = trimmedSearch.lowercased()
                            .components(separatedBy: allowedCharacters.inverted)
                            .joined()
                        let normalizedOptions = options.map {
                            $0.lowercased()
                              .components(separatedBy: allowedCharacters.inverted)
                              .joined()
                        }
                        let hasExactMatch = normalizedOptions.contains { $0 == normalizedSearch }
                        let hasPrefixMatch = normalizedOptions.contains { normalizedSearch != "" && $0.hasPrefix(normalizedSearch)}
                        if addNew && !trimmedSearch.isEmpty && !hasExactMatch && !hasPrefixMatch {
                            Button(action: {
                                isOptionSelected = true
                                isDropdownVisible = false
                            }){
                                HStack {
                                    Text(String(format: addNewTextFormat, searchText))
                                        .font(font)
                                        .foregroundColor(.white)
                                        .padding(.leading, 15)
                                    Spacer()
                                }
                                .padding(.vertical, 4)
                                .background(accentColor)
                                .cornerRadius(8)
                            }
                        } else if !addNew && searchText != "" && filteredOptions.isEmpty {
                            Text(noMatchText)
                                .font(font)
                                .foregroundColor(.gray)
                                .padding(.leading, 15)
                                .padding(.vertical, 4)
                        }
                    }
                }
                .frame(maxHeight: UIScreen.main.bounds.height - keyboardHeight - 100)
            }
        }
        .background(Color.clear)
        .onAppear {
            if options.count == 1 {
                selectOption(options[0])
            } else {
                selectOption(searchText)
            }
        }
        .onReceive(Publishers.keyboardHeight){ height in
            self.keyboardHeight = height
        }
    }
    
    private func selectOption(_ option: String){
        searchText = option
        isOptionSelected = true
        isDropdownVisible = false
        isSearchFieldFocused = false
    }
}

//MARK: - Private Helpers
extension DropdownTextField {
    private var filteredOptions: [String]{
        if searchText.isEmpty {
            return options
        } else {
            let allowedCharacters = CharacterSet.alphanumerics
            let normalizedSearchText = searchText.lowercased()
                .components(separatedBy: allowedCharacters.inverted)
                .joined()
            var results = [String]()
            let normalizedOptions = options.map {
                $0.lowercased()
                    .components(separatedBy: allowedCharacters.inverted)
                    .joined()
            }
            /// Exact matches
            results += options.enumerated().filter {
                normalizedOptions[$0.offset] == normalizedSearchText
            }.map { $0.element }
            
            /// Prefix matches
            results += options.enumerated().filter {
                normalizedOptions[$0.offset].hasPrefix(normalizedSearchText) && !results.contains($0.element)
            }.map { $0.element }
            
            /// Contains matches
            results += options.enumerated().filter {
                normalizedOptions[$0.offset].contains(normalizedSearchText) && !results.contains($0.element)
            }.map { $0.element }
            
            return results
        }
    }
    
    private var computedBorderColor: Color {
        if let borderColor = borderColor {
            return borderColor
        } else {
            if isOptionSelected && searchText.isEmpty {
                return textColor
            }
            if isOptionSelected {
                return successColor
            }
            if isDropdownVisible {
                return accentColor
            }
            return textColor
        }
    }
}
