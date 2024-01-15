//
//  EmptyRegionView.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import SwiftUI

// MARK: - Constant

private enum Constant {
    // swiftlint:disable:next no_magic_numbers
    static let aspectRatio: CGFloat = 1_024 / 435
    static let cornerRadius: CGFloat = 25
    static let fillColor: Color = .primary
    static let opacity = 0.1
}

// MARK: - View

struct EmptyRegionView: View {
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

// MARK: - Preview

#Preview {
    EmptyRegionView()
}
