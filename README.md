# PreviewResizable

A view modifier that allows custom resizing and size debugging in SwiftUI previews. Useful to quickly check how views adapt to different sizes.

## Motivation

Switching the target device just to check a view on different sizes can be slow sometimes. One missing feature in xcode is the option to run a preview in a freely resizable window (even on a separate window would be awesome) rather than always using the fixed size based on the selected device. For instance, on the physical iPad we can place apps in different sizes using Split View or Slide Over but this is not possible in a SwiftUI preview. This is just an example where the PreviewResizable modifier can be useful.

## How it works

The modifier wraps the content view into a container view that can be resized when running a Live preview. 

![PreviewResizable_canvas](https://user-images.githubusercontent.com/5954961/202699901-51af1e16-b330-48b5-a559-3d6a315a696b.gif)

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

* While resizing the view, both the size of the content and the container views are displayed so it’s easy to see whether the content view fits in the new area. 
* Double-clicking the resize button will adapt the container view size to the content size.

## Installation

1. From the File menu, select Add Packages...
2. Enter package repository URL: https://github.com/yannxou/PreviewResizable
3. Confirm the version and let Xcode resolve the package

## Tips

To avoid having to `import PreviewResizable` in every SwiftUI View that needs to use the `.previewResizable()` extension we can globally import it in our module with the `@_exported` keyword. Additionally, we can prevent it from being imported in release builds by wrapping the call in `#if` blocks. 

```swift
#if targetEnvironment(simulator)
@_exported import PreviewResizable
#endif
```

For temporary usages of the `PreviewResizable` modifier (we can add the extension to do some manual checks but remove afterwards) this is not an issue. But if we want to commit the preview code including the modifier call then the `PreviewProvider` implementation will also have to be wrapped in a similar `#if` block to prevent an error when building for release.

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
