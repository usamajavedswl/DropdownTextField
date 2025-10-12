//
//  MultiSelectionMenu.swift
//  MultiSelectionMenu
//
//  Created by Mian Usama on 08/10/2025.
//  Copyright © 2025 Usama Javed. All rights reserved.
//
//  Description:
//  A customizable searchable dropdown menu component built with SwiftUI.
//  Supports custom fonts, colors, and dynamic option filtering.
//  Designed and maintained by Usama Javed.
//

import SwiftUI
import Combine

@available(iOS 17.0, *)
public struct MultiSelectMenu: View {
    @State private var selectedOptions: [String] = []
    @State private var searchText: String = ""
    @State private var isOptionSelected: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @FocusState private var isSearchFieldFocused: Bool
    
    @Binding private var isDropdownVisible: Bool
    @Binding private var selectedValues: [String]
    private let options: [String]
    private let placeholder: String
    private let maxOptionsCount: Int
    private let addNew: Bool
    private let textColor: Color
    private let placeholderColor: Color
    private let accentColor: Color
    private let successColor: Color
    private let borderColor: Color?
    private let font: Font
    private let height: CGFloat
    private let cornerRadius: CGFloat
    private let noMatchText: String
    private let addNewTextFormat: String
    private let onTap: () -> Void
    
    // MARK: - Init
    public init(
        isDropdownVisible: Binding<Bool>,
        selectedValues: Binding<[String]>,
        options: [String],
        placeholder: String,
        maxOptionsCount: Int = 3,
        addNew: Bool = false,
        textColor: Color = .primary,
        placeholderColor: Color = .gray,
        accentColor: Color = .blue,
        successColor: Color = .green,
        borderColor: Color? = nil,
        font: Font = .system(size: 16),
        height: CGFloat = 40,
        cornerRadius: CGFloat = 8,
        noMatchText: String = "No match",
        addNewTextFormat: String = "Add %@",
        onTap: @escaping () -> Void
    ){
        self._isDropdownVisible = isDropdownVisible
        self._selectedValues = selectedValues
        self.options = options
        self.placeholder = placeholder
        self.maxOptionsCount = maxOptionsCount
        self.addNew = addNew
        self.onTap = onTap
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.accentColor = accentColor
        self.successColor = successColor
        self.borderColor = borderColor
        self.font = font
        self.height = height
        self.cornerRadius = cornerRadius
        self.noMatchText = noMatchText
        self.addNewTextFormat = addNewTextFormat
    }
    
    // MARK: - Body
    public var body: some View {
        VStack(spacing: 2){
            HStack(spacing: 0){
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 0){
                        ForEach(selectedOptions, id: \.self){ option in
                            HStack(spacing: 2){
                                Button(action: {
                                    removeOption(option)
                                    onTap()
                                }){
                                    Image(systemName: "xmark.circle.fill")
                                        .padding(.leading, 5)
                                        .foregroundColor(.white)
                                }
                                Text(option)
                                    .padding(.trailing, 5)
                                    .foregroundColor(.white)
                            }
                            .background(accentColor)
                            .cornerRadius(4)
                            .padding(.trailing, 5)
                        }
                        
                        if selectedOptions.count < maxOptionsCount {
                            ZStack(alignment: .leading){
                                if searchText.isEmpty {
                                    Text(placeholder)
                                        .font(font)
                                        .foregroundColor(placeholderColor.opacity(0.7))
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 0)
                                }
                                TextField("", text: $searchText, onEditingChanged: { isEditing in
                                    isDropdownVisible = isEditing
                                    if isEditing {
                                        isOptionSelected = false
                                        isSearchFieldFocused = true
                                        onTap()
                                    }
                                })
                                .focused($isSearchFieldFocused)
                                .font(font)
                                .tint(accentColor)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 0)
                                .foregroundColor(textColor)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .onTapGesture {
                                    isDropdownVisible.toggle()
                                    isSearchFieldFocused = isDropdownVisible
                                    if !searchText.isEmpty {
                                        searchText = ""
                                        isOptionSelected = false
                                        onTap()
                                    }
                                }
                                .onSubmit {
                                    if searchText.isEmpty {
                                        isDropdownVisible = false
                                    } else if let topOption = filteredOptions.first {
                                        selectOption(topOption)
                                    } else if addNew {
                                        selectOption(searchText)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
                .frame(height: height)
                .cornerRadius(cornerRadius)
            }
            .onTapGesture {
                isSearchFieldFocused = true
            }
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(currentBorderColor, lineWidth: 1)
            )
            
            if isDropdownVisible {
                ScrollView {
                    LazyVStack {
                        if addNew && searchText != "" &&
                            !filteredOptions.contains(where: { $0.lowercased().hasPrefix(searchText.lowercased())}){
                            Button(action: {
                                selectOption(searchText)
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
                            Text("\(noMatchText): \(searchText)")
                                .foregroundColor(.gray)
                                .font(font)
                                .padding(.leading, 15)
                                .padding(.vertical, 4)
                        }
                        
                        ForEach(filteredOptions.indices, id: \.self){ index in
                            let option = filteredOptions[index]
                            Button(action: {
                                selectOption(option)
                            }){
                                HStack {
                                    Text(option)
                                        .foregroundColor(index == 0 && !searchText.isEmpty ? .white : textColor)
                                        .padding(.leading, 15)
                                        .font(font)
                                    Spacer()
                                }
                                .padding(.vertical, 4)
                                .background(index == 0 && !searchText.isEmpty ? accentColor : Color.clear)
                                .cornerRadius(4)
                            }
                        }
                    }
                }
                .frame(maxHeight: UIScreen.main.bounds.height - keyboardHeight - 100)
            }
        }
        .background(Color.clear)
        .onAppear {
            for option in selectedValues {
                selectOption(option)
            }
        }
        .onChange(of: selectedValues){ oldValues, newValues in
            selectedOptions = newValues
        }
        .onReceive(Publishers.keyboardHeight){ height in
            self.keyboardHeight = height
        }
    }
}

// MARK: - Private helpers
@available(iOS 17.0, *)
extension MultiSelectMenu {
    private var filteredOptions: [String]{
        if searchText.isEmpty { return options }
        let allowed = CharacterSet.alphanumerics
        let normalizedSearch = searchText.lowercased()
            .components(separatedBy: allowed.inverted)
            .joined()
        
        var results: [String] = []
        let normalizedOptions = options.map {
            $0.lowercased().components(separatedBy: allowed.inverted).joined()
        }
        results += options.enumerated().filter { normalizedOptions[$0.offset] == normalizedSearch }.map { $0.element }
        results += options.enumerated().filter { normalizedOptions[$0.offset].hasPrefix(normalizedSearch) && !results.contains($0.element) }.map { $0.element }
        results += options.enumerated().filter { normalizedOptions[$0.offset].contains(normalizedSearch) && !results.contains($0.element) }.map { $0.element }
        return results
    }
    
    private var currentBorderColor: Color {
        if isOptionSelected && searchText.isEmpty {
            return textColor
        } else if isOptionSelected {
            return successColor
        } else if isDropdownVisible {
            return accentColor
        } else {
            return borderColor ?? textColor
        }
    }
    
    private func selectOption(_ option: String){
        if selectedOptions.count < maxOptionsCount && !selectedOptions.contains(option){
            selectedOptions.append(option)
            if !selectedValues.contains(option){
                selectedValues.append(option)
                onTap()
            }
            searchText = ""
            if selectedOptions.count >= maxOptionsCount {
                isDropdownVisible = false
                isSearchFieldFocused = false
            }
        }
    }
    
    private func removeOption(_ option: String){
        if let index = selectedValues.firstIndex(of: option){
            selectedValues.remove(at: index)
        }
        if let index = selectedOptions.firstIndex(of: option){
            selectedOptions.remove(at: index)
            isDropdownVisible = true
        }
    }
}
