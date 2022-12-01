//
//  ComponentView.swift
//  PreviewResizableExample
//
//  Created by Joan Duat on 21/11/22.
//

import SwiftUI

struct ComponentView: View {
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

struct ComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentView()
            .previewResizable()
            .previewLayout(.sizeThatFits)
    }
}
