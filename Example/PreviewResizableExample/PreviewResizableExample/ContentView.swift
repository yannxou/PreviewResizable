//
//  ContentView.swift
//  PreviewResizableExample
//
//  Created by Joan Duat on 11/11/22.
//

import SwiftUI
import PreviewResizable

struct ContentView: View {
    var body: some View {
        List {
            ComponentView()
            ComponentView()
            ComponentView()
            ComponentView()
            ComponentView()
            ComponentView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
            .previewResizable()
            .previewLayout(.fixed(width: 375, height: 800))
    }
}
