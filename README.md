# DropdownTextField
© 2025 Usama Javed. All rights reserved.

## Overview
DropdownTextField is a lightweight SwiftUI component that provides a searchable dropdown text field with customizable design and behavior.
It allows users to type, filter, and select from a list of options — similar to a searchable picker or auto-complete field.

### The library is designed to be:
* Simple to integrate
* Easy to customize (colors, fonts, sizes, etc.)
* Flexible enough to fit any SwiftUI project

### Installation (Swift Package Manager)
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

### Usage Example
Here’s how to use SearchableMenu inside your SwiftUI view:


```swift
import SwiftUI
import DropdownTextField
  
struct ContentView: View {
    @State private var searchText = ""
    @State private var isDropdownVisible = false
    private let options = ["Apple", "Mango", "Banana", "Cherry", "Orange"]

    var body: some View {
        VStack(spacing: 20){
            Text("Select a Fruit")
                .font(.headline)

            SearchableMenu(
                searchText: $searchText,
                isDropdownVisible: $isDropdownVisible,
                options: options,
                placeholder: "Search or select fruit"
            ){
                print("Dropdown tapped")
            }
            .padding(.horizontal, 16)
        }
        .padding()
    }
}
```


### Full Initializer
For customization, you can use all available parameters:

```swift
SearchableMenu(
    searchText: $searchText,
    isDropdownVisible: $isDropdownVisible,
    options: ["Swift", "Kotlin", "Dart", "Java"],
    placeholder: "Select language",
    addNew: true,
    textColor: .black,
    placeholderColor: .gray,
    accentColor: .blue,
    successColor: .green,
    destructiveColor: .red,
    borderColor: .gray,
    font: .system(size: 14, weight: .medium),
    height: 48,
    cornerRadius: 10,
    dropdownIcon: Image(systemName: "chevron.down"),
    noMatchText: "No results found",
    addNewTextFormat: "Add \"%@\""
){
    print("Dropdown opened")
}
```

### Notes
**onTap** is called when the dropdown field becomes active.
**addNew** enables the option to add new items that don’t exist in the list.
The view automatically filters options based on the typed text.

## License
© 2025 Usama Javed. All rights reserved.
This Swift package is owned and maintained by Usama Javed.
All rights reserved. Redistribution without permission is prohibited.
