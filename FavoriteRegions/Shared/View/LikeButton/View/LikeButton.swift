//
//  LikeButton.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import SwiftUI

// MARK: - View

struct LikeButton: View {
    @ObservedObject var viewModel: LikeButtonViewModel
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        Button {
            feedbackGenerator.impactOccurred()
            viewModel.likeButtonTapped()
        } label: {
            if viewModel.isFollowed {
                FilledHearth()
            } else {
                EmptyHearth()
            }
        }.buttonStyle(PulsingButtonStyle())
    }
}
