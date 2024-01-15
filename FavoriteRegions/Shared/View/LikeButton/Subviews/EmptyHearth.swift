//
//  EmptyHearth.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import SwiftUI

// MARK: - Constant

private enum Constant {
    static let heartStr = "suit.heart"
    static let heartAspectRatio: CGFloat = 1.2
}

// MARK: - View

struct EmptyHearth: View {
    var body: some View {
        Image(systemName: Constant.heartStr)
            .resizable()
            .aspectRatio(
                Constant.heartAspectRatio,
                contentMode: .fit
            )
    }
}

#Preview {
    EmptyHearth()
}
