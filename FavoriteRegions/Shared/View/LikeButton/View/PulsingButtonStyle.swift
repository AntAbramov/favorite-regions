//
//  PulsingButtonStyle.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import SwiftUI

// MARK: - Constant

private enum Constant {
    static let pressedOpacity: CGFloat = 0.8
    static let defaultOpacity: CGFloat = 1.0
    static let pressedScale: CGFloat = 0.95
    static let defaultScale: CGFloat = 1
}

// MARK: - ButtonStyle

struct PulsingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(
                configuration.isPressed
                     ? Constant.pressedOpacity
                     : Constant.defaultOpacity
            )
            .scaleEffect(
                configuration.isPressed
                ? Constant.pressedScale
                : Constant.defaultScale
            )
    }
}
