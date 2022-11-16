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
        HStack {
            VStack(alignment: .leading) {
                Image(systemName: "sunrise")
                    .imageScale(.large)
                    .foregroundColor(.orange)
                Text("See how this view adapts to different sizes")
            }
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
        }
        .padding()
        .frame(minWidth: 200, maxWidth: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
            .previewResizable()
    }
}
