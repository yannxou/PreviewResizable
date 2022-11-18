# PreviewResizable

A view modifier that allows custom resizing and size debugging in SwiftUI previews. Useful to quickly check how views adapt to different sizes.

## Motivation

Switching the target device just to check a view on different sizes can be slow sometimes. One missing feature in xcode is the option to run a preview in a freely resizable window (even on a separate window would be awesome) rather than always using the fixed size based on the selected device. For instance, on the physical iPad we can place apps in different sizes using Split View or Slide Over but this is not possible in a SwiftUI preview. This is just an example where the PreviewResizable modifier can be useful.

## How it works

The modifier wraps the content view into a container view that can be resized when running a Live preview. 

> TODO: include gif

## Usage

Just add the `previewResizable()` modifier to your view.

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewResizable()
    }
}
```

While resizing the view, both the size of the content and the container views are displayed so it’s easy to see whether the content view fits in the new area. 

Double-clicking the resize button will adapt the container view size to the content size.

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
