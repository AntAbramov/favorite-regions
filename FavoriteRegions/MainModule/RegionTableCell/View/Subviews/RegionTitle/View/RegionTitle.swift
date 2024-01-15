//
//  RegionTitle.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import SwiftUI

// MARK: - Constant

private enum Constant {
    private static let fontSize: CGFloat = 23
    static let titleFont: Font = .system(size: fontSize, weight: .bold)
    static let titleColor: Color = .white
    static let shadowY: CGFloat = 2
    static let shadowX: CGFloat = 0
    static let shadowRadius: CGFloat = 3
    static let shadowColor: Color = .black
}

// MARK: - View

struct RegionTitle: View {
    @ObservedObject var viewModel: RegionTitleViewModel
    
    var body: some View {
        Text(viewModel.title)
            .font(Constant.titleFont)
            .foregroundStyle(Constant.titleColor)
            .shadow(
                color: Constant.shadowColor,
                radius: Constant.shadowRadius,
                x: Constant.shadowX,
                y: Constant.shadowY
            )
    }
}

// MARK: - Preview

#Preview {
    RegionTitle(
        viewModel: RegionTitleViewModel(
            title: "Moscow"
        )
    )
}
