# FigmaKit

A library to make ui code synchronize with designer's works

## Features

- [x] Colors, corners, shadow, strokes, fill
- [x] Label attributed
- [ ] SwiftUI

### Colors and Fill

From designer perspective

<img src="./Resources/sample1.png" width="200" >

To developer's code.
```swift
topView
    .corner(.mixed(20, 50, 0, 50))
    .fill(.linear(colors: [(0xEBEBEB, 0), (0x9EE505, 1)], alpha: 90))
    .stroke(.inside(0xFFFFFF, size: 5))
    .shadow(.drop(0x000000, x: 0, y: 4, b: 4, s: 0, alpha: 25))
```


### Multiple corners' radius

<img src="./Resources/corners.png" width="200" >

```swift
view
    .corner(.mixed(20, 50, 0, 50))
```

### Gradient or solid - *In progress*

<img src="./Resources/fills.png" width="200" >

```swift
view
    .fill(.linear(colors: [(0xEBEBEB, 0), (0x9EE505, 1)], alpha: 90))
```


### Stroke inside, outside or center

<img src="./Resources/strokes.png" width="200" >

```swift
view
    .stroke(.inside("#FFFFFF", size: 5))
```


### And shadows

<img src="./Resources/shadows.png" width="200" >

```swift
topView
    .shadow(.drop(0x000000, x: 0, y: 4, b: 4, s: 0, alpha: 25))
```


Final result 

<img src="./Resources/results.png" width="200" >


## Styles

### Simple style for label
```swift
sampleLabel
    .typography(.custom(name: "Roboto", weight: 400, size: 16, lineHeight: 20.0))
```

### Label Rich Text

<img src="./Resources/typos.png" width="300" >

```swift
let normal = Typography.custom(name: "Roboto", weight: 400, size: 16)
let bold = Typography.custom(name: "Roboto", weight: 700, size: 20)

let foreground = 0x000000
let green = 0x00FF00
let grey = 0xCCCCCC

sampleLabel
    
    // Mark default style
    .registerDefaults(typography: normal, color: foreground)
    
    .add("Lorem".normal(bold.font, color: grey))
    .add(" ipsum dolor sit".normal(normal.font, color: green))
    .add(" amet ")
    .add("consectetur adipiscing elit", style: .underlined)
    .add(", sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n")
    .add("Ut enim ad minim veniam", style: .strikeThrough)
    .add(" quis nostrud ".normal(bold.font, color: foreground, background: green))
    .add("exercitation", style: .link("https://google.com"))
    .add(" ullamco laboris nisi ut aliquip ex ea commodo ")
    .add("consequat.".normal(bold.font, color: 0xFF0000))
    
    // Label-wide applying should be done finally
    .alignment(.left)
    .lineSpacing(5)
    
    // Don't forget to clean for next use
    .unregister()
```

## Requirement

iOS 11.0+
Swift 4.0+

## Installation

### Swift Package manager

- Click `File` → `Swift Packages` → `Add Package Dependency`
- Enter `https://github.com/haphanquang/FigmaKit`

## Support

Ask me anything at https://hapq.me/contact

## License

FigmaKit is released under the Unlicense. See LICENSE for details.
