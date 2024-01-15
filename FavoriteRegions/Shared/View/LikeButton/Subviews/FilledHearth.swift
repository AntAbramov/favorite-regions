//
//  FilledHearth.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import SwiftUI

// MARK: - Constant

private enum Constant {
    static let heartStr = "suit.heart.fill"
    static let foregroundColor: Color = .red
    static let hearthAspectRatio: CGFloat = 1.2
}

// MARK: - View

struct FilledHearth: View {
    var body: some View {
        Image(systemName: Constant.heartStr)
            .resizable()
            .foregroundColor(Constant.foregroundColor)
            .aspectRatio(
                Constant.hearthAspectRatio,
                contentMode: .fit
            )
    }
}

#Preview {
    FilledHearth()
}
