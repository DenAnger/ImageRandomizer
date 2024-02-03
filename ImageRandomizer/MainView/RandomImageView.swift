//
//  RandomImageView.swift
//  ImageRandomizer
//
//  Created by Denis Abramov on 01.02.2024.
//

import SwiftUI

struct RandomImageView: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}
