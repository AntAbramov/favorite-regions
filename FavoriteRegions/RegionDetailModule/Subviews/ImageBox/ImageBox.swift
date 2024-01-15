//
//  ImageBox.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 15.01.2024.
//

import SwiftUI

// MARK: - Constant

private enum Constant {
    // swiftlint:disable:next no_magic_numbers
    static let aspectRatio: CGFloat = 1_024 / 435
    static let imageCornerRadius: CGFloat = 10
    
    static let loadedImageOpacity: Double = 1
    static let notLoadedImageOpacity: Double = 0.6
    static let imageAppearAnimation: Animation = .interactiveSpring(
        duration: animationDuration
    )
    private static let animationDuration = 0.4
}

// MARK: - View

struct ImageBox: View, Identifiable {
    // MARK: Property
    @ObservedObject var viewModel: ImageBoxViewModel
    var id: UUID = .init()
    
    @State private var imageOpacity = Constant.notLoadedImageOpacity
    
    // MARK: body
    var body: some View {
        if viewModel.isLoading {
            ImageShimmer()
        } else if let imageData = viewModel.imageData,
                  let image = Image(data: imageData) {
            configure(image)
                .opacity(imageOpacity)
                .onAppear {
                    withAnimation(Constant.imageAppearAnimation) {
                        imageOpacity = Constant.loadedImageOpacity
                    }
                }
        } else {
            EmptyView()
                .aspectRatio(
                    Constant.aspectRatio,
                    contentMode: .fit
                )
        }
    }
}

// MARK: - Equatable

extension ImageBox: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Private methods

private extension ImageBox {
    func configure(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(
                Constant.aspectRatio,
                contentMode: .fit
            ).clipShape(
                RoundedRectangle(
                    cornerRadius: Constant.imageCornerRadius
                )
            )
    }
}
