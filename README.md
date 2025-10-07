<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>DropdownTextField — README</title>
  <style>
    :root{
      --bg:#ffffff;
      --text:#0b1220;
      --muted:#6b7280;
      --accent:#1f6feb;
      --card:#f8fafc;
      --border:#e6e9ee;
      --mono:#0b1220;
      font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
    }
    body{
      margin:0;
      background:var(--bg);
      color:var(--text);
      line-height:1.6;
      padding:32px;
    }
    .container{
      max-width:960px;
      margin:0 auto;
    }
    header h1{
      margin:0 0 8px 0;
      font-size:28px;
      letter-spacing:-0.3px;
    }
    header p.lead{
      margin:0 0 20px 0;
      color:var(--muted);
    }
    .card{
      background:var(--card);
      border:1px solid var(--border);
      padding:18px;
      border-radius:8px;
      margin-bottom:20px;
    }
    h2{
      margin:18px 0 8px 0;
      font-size:20px;
    }
    pre{
      background:#0b1220;
      color:#e6eef8;
      padding:14px;
      border-radius:6px;
      overflow:auto;
      font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, "Roboto Mono", "Courier New", monospace;
      font-size:13px;
    }
    code{font-family: inherit;}
    table{width:100%; border-collapse:collapse; margin-top:8px;}
    th, td{padding:8px 10px; border:1px solid var(--border); text-align:left;}
    th{background:#f1f5f9;}
    footer{color:var(--muted); font-size:13px; margin-top:30px; text-align:center;}
    .small{font-size:13px; color:var(--muted);}
    .btn{
      display:inline-block;
      padding:8px 12px;
      background:var(--accent);
      color:#fff;
      border-radius:6px;
      text-decoration:none;
      font-weight:600;
      margin-top:6px;
    }
    @media (max-width:640px){
      body{padding:16px;}
    }
  </style>
</head>
<body>
  <div class="container">
    <header>
      <h1>DropdownTextField</h1>
      <p class="lead">A lightweight, fully customizable searchable dropdown component for SwiftUI.</p>
      <p class="small">© 2025 Usama Javed. All rights reserved.</p>
    </header>

    <section class="card">
      <h2>Overview</h2>
      <p>
        <strong>DropdownTextField</strong> provides <code>SearchableMenu</code>, a SwiftUI view that implements a searchable dropdown list.
        It supports bound state, dynamic filtering, an optional "Add New" action, and flexible appearance options.
      </p>
    </section>

    <section class="card">
      <h2>Installation</h2>
      <p><strong>Swift Package Manager (SPM)</strong></p>
      <ol>
        <li>In Xcode, open your project.</li>
        <li>Choose <em>File → Add Packages…</em></li>
        <li>Enter the repository URL (example):</li>
      </ol>
      <pre><code>https://github.com/usamajavedswl/DropdownTextField.git</code></pre>
      <p>Select the desired version and add the package to your target.</p>
    </section>

    <section class="card">
      <h2>Basic Usage</h2>
      <p>Import the package and embed <code>SearchableMenu</code> in your SwiftUI view:</p>

      <pre><code>import SwiftUI
import DropdownTextField

struct ContentView: View {
    @State private var searchText = ""
    @State private var isDropdownVisible = false
    private let options = ["Apple", "Mango", "Banana", "Cherry", "Orange"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Select a Fruit")
                .font(.headline)

            SearchableMenu(
                searchText: $searchText,
                isDropdownVisible: $isDropdownVisible,
                options: options,
                placeholder: "Search or select fruit"
            ) {
                print("Option tapped: \(searchText)")
            }
            .padding(.horizontal, 16)
        }
        .padding()
    }
}</code></pre>
    </section>

    <section class="card">
      <h2>Customization</h2>
      <p>The initializer accepts several parameters for appearance and behavior. Most parameters have sensible defaults.</p>

      <table>
        <thead>
          <tr><th>Parameter</th><th>Type</th><th>Description</th></tr>
        </thead>
        <tbody>
          <tr><td><code>searchText</code></td><td><code>Binding&lt;String&gt;</code></td><td>Bound text for the search input.</td></tr>
          <tr><td><code>isDropdownVisible</code></td><td><code>Binding&lt;Bool&gt;</code></td><td>Controls dropdown list visibility.</td></tr>
          <tr><td><code>options</code></td><td><code>[String]</code></td><td>Source list of selectable values.</td></tr>
          <tr><td><code>placeholder</code></td><td><code>String</code></td><td>Placeholder text when input is empty.</td></tr>
          <tr><td><code>addNew</code></td><td><code>Bool</code></td><td>Allow creating a new item when not found.</td></tr>
          <tr><td><code>onTap</code></td><td><code>() -&gt; Void</code></td><td>Called when the dropdown field becomes active.</td></tr>
          <tr><td><code>textColor</code></td><td><code>Color</code></td><td>Text color for input and items.</td></tr>
          <tr><td><code>placeholderColor</code></td><td><code>Color</code></td><td>Color used for placeholder text.</td></tr>
          <tr><td><code>accentColor</code></td><td><code>Color</code></td><td>Accent color for highlights and icon.</td></tr>
          <tr><td><code>successColor</code></td><td><code>Color</code></td><td>Color used to indicate selection success.</td></tr>
          <tr><td><code>destructiveColor</code></td><td><code>Color</code></td><td>Optional color for destructive actions.</td></tr>
          <tr><td><code>borderColor</code></td><td><code>Color?</code></td><td>Custom border color; computed by component if <code>nil</code>.</td></tr>
          <tr><td><code>font</code></td><td><code>Font</code></td><td>Font used for input and option rows.</td></tr>
          <tr><td><code>height</code></td><td><code>CGFloat</code></td><td>Height of the main input field.</td></tr>
          <tr><td><code>cornerRadius</code></td><td><code>CGFloat</code></td><td>Corner radius for the field background.</td></tr>
          <tr><td><code>dropdownIcon</code></td><td><code>Image</code></td><td>Custom icon for the dropdown indicator.</td></tr>
          <tr><td><code>noMatchText</code></td><td><code>String</code></td><td>Text shown when no results are found.</td></tr>
          <tr><td><code>addNewTextFormat</code></td><td><code>String</code></td><td>Format string used for the Add New button (use <code>%@</code> for the typed text).</td></tr>
        </tbody>
      </table>

      <p>Example with custom styling:</p>

      <pre><code>SearchableMenu(
  searchText: $searchText,
  isDropdownVisible: $isDropdownVisible,
  options: ["Swift", "Kotlin", "Dart", "Java"],
  placeholder: "Select language",
  addNew: true,
  onTap: {
      print("Dropdown opened")
  },
  textColor: .black,
  placeholderColor: .gray,
  accentColor: .blue,
  successColor: .green,
  borderColor: .blue,
  font: .system(size: 14, weight: .medium),
  height: 44,
  cornerRadius: 10,
  dropdownIcon: Image(systemName: "chevron.down"),
  noMatchText: "No results found",
  addNewTextFormat: "Add \"%@\""
)</code></pre>
    </section>

    <section class="card">
      <h2>Filtering Logic</h2>
      <p>The built-in filtering prioritizes results in this order:</p>
      <ol>
        <li>Exact match</li>
        <li>Prefix match</li>
        <li>Contains match</li>
      </ol>
      <p>This ordering surfaces the most relevant items first.</p>
    </section>

    <section class="card">
      <h2>Notes on Fonts and Resources</h2>
      <p>
        If you bundle custom fonts inside the Swift package, ensure fonts are placed under the package resource folder:
      </p>
      <pre><code>Sources/DropdownTextField/Resources/Fonts/YourFont.ttf</code></pre>
      <p>
        Register fonts programmatically using <code>CTFontManagerRegisterFontsForURL</code> from your package so <code>Font.custom(...)</code> works in consumer apps.
      </p>
    </section>

    <section class="card">
      <h2>License & Copyright</h2>
      <p>© 2025 Usama Javed. All rights reserved.</p>
      <p class="small">
        This repository and its contents are maintained by Usama Javed. If you wish to use this package in other projects,
        please credit the original source. For open-source licensing, consider adding an appropriate LICENSE file such as MIT.
      </p>
    </section>

    <footer>
      <p class="small">For issues, suggestions, or contributions, please open an issue or a pull request in the repository.</p>
    </footer>
  </div>
</body>
</html>
