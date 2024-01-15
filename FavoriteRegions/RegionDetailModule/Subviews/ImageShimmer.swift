//
//  ImageShimmer.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 15.01.2024.
//

import SwiftUI

// MARK: - Constant

private enum Constant {
    static let cornerRadius: CGFloat = 10
    static let fillColor: Color = .gray
    static let opacity = 0.3
    // swiftlint:disable:next no_magic_numbers
    static let aspectRatio: CGFloat = 1_024 / 435
}

// MARK: - View

struct ImageShimmer: View {
    var body: some View {
        RoundedRectangle(cornerRadius: Constant.cornerRadius)
            .fill(Constant.fillColor)
            .opacity(Constant.opacity)
            .aspectRatio(
                Constant.aspectRatio,
                contentMode: .fit
            )
    }
}
