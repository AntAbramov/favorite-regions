//
//  RegionTableCell.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import SwiftUI

// MARK: - Constant

private enum Constant {
    static let titlePadding: CGFloat = 10
    static let backCirclePadding: CGFloat = 10
    static let imageCornerRadius: CGFloat = 25
    static let backCircleWidth: CGFloat = 40
    static let hearthWidth: CGFloat = 25
    static let isLoadedOpacity: Double = 1
    static let isNotLoadedOpacity: Double = 0.6
    static let imageAppearAnimation: Animation = .interactiveSpring(
        duration: animationDuration
    )
    private static let animationDuration = 0.4
}

// MARK: - View

struct RegionTableCell: View {
    @ObservedObject var viewModel: RegionTableCellViewModel
        
    @State private var imageOpacity = Constant.isNotLoadedOpacity
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                RegionProgressView()
            } else if let imageData = viewModel.imageData,
                      let image = Image(data: imageData) {
                configure(image)
                    .overlay(alignment: .bottomLeading) {
                        RegionTitle(
                            viewModel: viewModel.createRegionTitleViewModel()
                        ).padding(Constant.titlePadding)
                    }
                    .opacity(imageOpacity)
                    .onAppear {
                        withAnimation(Constant.imageAppearAnimation) {
                            imageOpacity = Constant.isLoadedOpacity
                        }
                    }
            } else {
                EmptyRegionView()
            }
        }.overlay(alignment: .topTrailing) {
            createLikeButton()
        }
    }
}

// MARK: - UI creation methods

private extension RegionTableCell {
    func configure(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .clipShape(
                RoundedRectangle(
                    cornerRadius: Constant.imageCornerRadius,
                    style: .continuous
                )
            )
    }
    
    func createLikeButton() -> some View {
        BackgroundCircle()
            .frame(width: Constant.backCircleWidth)
            .padding(Constant.backCirclePadding)
            .overlay {
                LikeButton(
                    viewModel: viewModel.createLikeButtonViewModel()
                )
                .frame(width: Constant.hearthWidth)
                .foregroundStyle(.white)
            }
    }
}
