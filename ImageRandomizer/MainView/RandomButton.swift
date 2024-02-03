//
//  RandomButton.swift
//  ImageRandomizer
//
//  Created by Denis Abramov on 01.02.2024.
//

import SwiftUI

struct RandomButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Change Image")
                .padding()
                .background(Color.green)
                .foregroundColor(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .padding(.bottom, 20)
    }
}
