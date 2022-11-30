//
//  PreviewResizableViewModifier.swift
//  PreviewResizable
//
//  Created by Joan Duat on 8/11/22.
//

import SwiftUI

struct PreviewResizableViewModifier: ViewModifier {

    @State private var size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
    @State private var isDragging = false
    @State private var contentSize: CGSize = .zero

    private let handleSize: CGFloat = 30
    private let minSize: CGSize = .init(width: 30, height: 30)
    private var isContentFitting: Bool {
        size.width >= contentSize.width && size.height >= contentSize.height
    }

    func body(content: Content) -> some View {
        GeometryReader { proxy in
            let maxSize = CGSize(width: proxy.size.width, height: proxy.size.height + proxy.safeAreaInsets.bottom)
            ZStack(alignment: .crossAlignment) {
                contentWrapper(content)
                    .frame(width: min(maxSize.width, size.width), height: min(maxSize.height, size.height))
                    .overlay(rectangleHint)
                    .frame(width: size.width, height: size.height, alignment: .topLeading)

                sizeDisplay
                    .alignmentGuide(.crossHorizontalAlignment, computeValue: { d in
                        size.width < 120 ? d[HorizontalAlignment.leading] - 10 : 120 })

                dragHandle(maxSize: maxSize)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    private var rectangleHint: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(isContentFitting ? .gray : .red)
    }

    private func dragHandle(maxSize: CGSize) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "arrow.up.backward.and.arrow.down.forward")
                .frame(width: handleSize, height: handleSize)
                .dynamicTypeSize(.large)
                .background(Color.gray.opacity(0.2).frame(width: handleSize, height: handleSize))
                .gesture(DragGesture(minimumDistance: 0.0)
                    .onChanged { value in
                        isDragging = true
                        size = CGSize(
                            width: min(maxSize.width, max(minSize.width, size.width + value.translation.width)),
                            height: min(maxSize.height, max(minSize.height, size.height + value.translation.height))
                        )
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
                )
        }
        .simultaneousGesture(
            TapGesture(count: 2).onEnded { _ in
                // Size to fit:
                size = CGSize(width: min(maxSize.width, contentSize.width), height: min(maxSize.height, contentSize.height))
            }
        )
    }

    private var sizeDisplay: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text("\(text(for: contentSize))")
                .foregroundColor(.white)
                .background(Color.accentColor)

            Text("\(text(for: size))")
                .foregroundColor(isContentFitting ? .primary : .white)
                .background(isContentFitting ? Color(uiColor: .systemGroupedBackground) : .red)
        }
        .font(.caption)
        .dynamicTypeSize(.large)
        .opacity(isDragging ? 1 : 0)
        .transition(.opacity)
        .animation(.interactiveSpring(), value: isDragging)
    }

    private func contentWrapper(_ content: Content) -> some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                ChildSizeReader(size: $contentSize) {
                    content
                }
                .border(Color.accentColor, width: isDragging ? 1 : 0)
            }
        }
    }

    private func text(for size: CGSize) -> String {
        String(format: "%.1f x %.1f", size.width, size.height)
    }
}

// MARK: - Alignment extensions

fileprivate extension Alignment {
    static let crossAlignment = Alignment(horizontal: .crossHorizontalAlignment, vertical: .bottom)
}
fileprivate extension HorizontalAlignment {
    private enum CrossHorizontalAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.trailing]
        }
    }
    static let crossHorizontalAlignment = HorizontalAlignment(CrossHorizontalAlignment.self)
}

// MARK: - View extension

public extension View {

    /// Makes the container for the preview resizable.
    ///
    /// During resizing both the size of the content and the container views are displayed so it’s easy to see whether the content view fits in the new area.
    ///
    /// Double-clicking the resize button adapts the container view size to the content size.
    func previewResizable() -> some View {
        modifier(PreviewResizableViewModifier())
    }
}

