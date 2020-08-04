# SwiftUIDictionary

A SwiftUI Text View with interactive definition inspection.

### Demo
![Demo](https://github.com/p-larson/SwiftUIDictionary/blob/master/recording.gif)

### Usage
```swift
import SwiftUIDictionary

let definitions: [Definition] = [
    Definition(word: "SwiftUI", value: "Declare the user interface and behavior for your app on every platform."),
    Definition(word: "p.larson", value: "A really rad dude.")
]

struct ContentView: View {
    var body: some View {
        DictionaryView("SwiftUI is Awesome!", vocab: definitions)
    }
}
```
## Installation
1. Add `SwiftUIDictionary` to SPM
2. Import `SwiftUIDictionary`
3. Define your text (`String`) and Definitions (`[Definition]`)
4. Create your `DictionaryView`
