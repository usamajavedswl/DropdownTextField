# DropdownTextField & MultiSelectionMenu – SwiftUI Components
© 2025 Usama Javed. All rights reserved.


## Overview
A lightweight and reusable set of SwiftUI components for building custom dropdown menus and multi-select menus with smooth UI, dynamic filtering, and tag-like selections.
These components are designed for iOS 17+ and can be easily integrated into SwiftUI projects.

### The library is designed to be:
* Simple to integrate
* Easy to customize (colors, fonts, sizes, etc.)
* Flexible enough to fit any SwiftUI project


## 📌 Features
✅ DropdownTextField – Single selection dropdown with search and optional “Add New” entry.
✅ MultiSelectionMenu – Multi-select dropdown with tag-style chips and search support.
✅ Customizable colors, fonts, and corner radii.
✅ Keyboard-aware dropdown list.
✅ “No match” and “Add new” behaviors built-in.
✅ Written purely in SwiftUI.



## 🚀 Installation

### Swift Package Manager
1. In Xcode, open your project.
2. Go to File → Add Packages...
3. Enter the repository URL:

```
https://github.com/usamajavedswl/DropdownTextField.git
```

4. Choose the latest version and add it to your target.
Then simply import it:

```swift 
import DropdownTextField
```



## 🧩 Usage

### Example – DropdownTextField

```swift
struct ExampleDropdown: View {
    @State private var searchText: String = ""
    @State private var isDropdownVisible: Bool = false
    
    let options = ["Apple", "Banana", "Orange", "Mango"]
    
    var body: some View {
        DropdownTextField(
            searchText: $searchText,
            isDropdownVisible: $isDropdownVisible,
            options: options,
            placeholder: "Select a fruit",
            addNew: true
        ){
            print("Dropdown tapped")
        }
        .padding()
    }
}
```

### Example – MultiSelectionMenu

```swift
struct ExampleMultiSelect: View {
    @State private var isDropdownVisible: Bool = false
    @State private var selectedValues: [String] = []
    
    let options = ["Swift", "Kotlin", "Java", "Python", "JavaScript"]
    
    var body: some View {
        MultiSelectionMenu(
            isDropdownVisible: $isDropdownVisible,
            selectedValues: $selectedValues,
            options: options,
            placeholder: "Select languages",
            maxOptionsCount: 5,
            addNew: true
        ){
            print("Multi-selection tapped")
        }
        .padding()
    }
}
```



## ⚙️ Parameters

### DropdownTextField

| Parameter           | Type            | Default             | Description                       |
| ------------------- | --------------- | ------------------- | --------------------------------- |
| `searchText`        | Binding<String> | –                   | Text binding for search/selection |
| `isDropdownVisible` | Binding<Bool>   | –                   | Controls dropdown visibility      |
| `options`           | [String]        | –                   | Dropdown options                  |
| `placeholder`       | String          | –                   | Placeholder text                  |
| `addNew`            | Bool            | `false`             | Allow adding new custom text      |
| `textColor`         | Color           | `.primary`          | Text color                        |
| `placeholderColor`  | Color           | `.gray`             | Placeholder color                 |
| `accentColor`       | Color           | `.blue`             | Highlight color                   |
| `successColor`      | Color           | `.green`            | Success state color               |
| `destructiveColor`  | Color           | `.red`              | Not used but customizable         |
| `borderColor`       | Color?          | `nil`               | Border color (optional)           |
| `font`              | Font            | `.system(size: 16)` | Font styling                      |
| `height`            | CGFloat         | `40`                | Field height                      |
| `cornerRadius`      | CGFloat         | `8`                 | Rounded corners                   |
| `dropdownIcon`      | Image           | `chevron.down`      | Dropdown toggle icon              |
| `noMatchText`       | String          | `"No match"`        | Shown when no match               |
| `addNewTextFormat`  | String          | `"Add %@"`          | Format for new entry              |
| `onTap`             | () -> Void      | –                   | Callback on tap                   |


### MultiSelectionMenu

| Parameter           | Type              | Default             | Description                     |
| ------------------- | ----------------- | ------------------- | ------------------------------- |
| `isDropdownVisible` | Binding<Bool>     | –                   | Controls dropdown visibility    |
| `selectedValues`    | Binding<[String]> | –                   | Stores selected options         |
| `options`           | [String]          | –                   | Dropdown options                |
| `placeholder`       | String            | –                   | Placeholder text                |
| `maxOptionsCount`   | Int               | `3`                 | Maximum allowed selections      |
| `addNew`            | Bool              | `false`             | Allow adding new custom entries |
| `textColor`         | Color             | `.primary`          | Text color                      |
| `placeholderColor`  | Color             | `.gray`             | Placeholder color               |
| `accentColor`       | Color             | `.blue`             | Highlight color                 |
| `successColor`      | Color             | `.green`            | Success state color             |
| `borderColor`       | Color?            | `nil`               | Border color                    |
| `font`              | Font              | `.system(size: 16)` | Font styling                    |
| `height`            | CGFloat           | `40`                | Field height                    |
| `cornerRadius`      | CGFloat           | `8`                 | Rounded corners                 |
| `noMatchText`       | String            | `"No match"`        | Shown when no match             |
| `addNewTextFormat`  | String            | `"Add %@"`          | Format for new entry            |
| `onTap`             | () -> Void        | –                   | Callback on tap                 |




## 🤝 Contributing
Contributions are welcome!
* Fork the repo
* Create a new branch (feature/my-feature)
* Commit your changes
* Open a Pull Request

Please ensure all changes are consistent with SwiftUI’s declarative style and include example usage.



## 📜 License
© 2025 Usama Javed. All rights reserved.
This Swift package is owned and maintained by Usama Javed.
All rights reserved. Redistribution without permission is prohibited.
