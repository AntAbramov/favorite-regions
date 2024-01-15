//
//  BackgroundCircle.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import SwiftUI

// MARK: - Constant

private enum Constant {
    static let fillColor: Color = .black
    static let circleOpacity: Double = 0.4
}

// MARK: - View

struct BackgroundCircle: View {
    var body: some View {
        Circle()
            .fill(Constant.fillColor)
            .aspectRatio(contentMode: .fit)
            .opacity(Constant.circleOpacity)
    }
}

#Preview {
    BackgroundCircle()
}
