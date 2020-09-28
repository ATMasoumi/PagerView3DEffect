# PagerView3DEffect
## Info
pager view like iTunes paging in SwiftUI 
## Gifs
![](gifFile@.gif)
![](gifFile1.gif)
## Setup

```swift
PagerView3DEffect(selection: $index, data , spacing: 10) { int in
    Rectangle()
        .foregroundColor(.red)
        .cornerRadius(10)
        .frame(width: 100, height: 100, alignment: .center)         
}
```
