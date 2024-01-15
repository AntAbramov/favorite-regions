//
//  RegionDetailView.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 15.01.2024.
//

import SwiftUI

// MARK: - Constant

private enum Constant {
    // swiftlint:disable:next no_magic_numbers
    static let imageAspectRatio: CGFloat = 1_024 / 435
    static let imageSelectAnimation: Animation = .spring(
        response: selectResponse,
        dampingFraction: selectDampingFraction
    )
    static let viewCountLabelFontSize: CGFloat = 18
    static let gridItemSize: CGFloat = 180
    static let titleLabelFontSize: CGFloat = 30
    static let itemSpacing: CGFloat = 10
    static let imageDropHeight: CGFloat = 200
    static let likeButtonWidth: CGFloat = 30
    static let likeButtonHeight: CGFloat = 25
    static let imageZIndexSelected: Double = 1
    static let imageZIndexNotSelected: Double = 0
    static let imageZIndexTop: Double = 2
    static let nothingSelectedColorOpacity: Double = 0
    private static let selectResponse: CGFloat = 0.4
    private static let selectDampingFraction: CGFloat = 0.75
}

// MARK: - View

struct RegionDetailView: View {
    @Namespace var namespace
    
    // MARK: Dependency
    @ObservedObject var viewModel: RegionDetailViewModel
    
    // MARK: @State
    @State private var selectedImageBox: ImageBox?
    @State private var position = CGSize.zero
    
    // MARK: body
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    createTitleLabel()
                    createViewCountLabel()
                    createImageGrid()
                }
            }.scrollIndicators(.hidden)
                        
            createSelectedImageOverlay()

            if let selected = selectedImageBox,
               let imageData = selected.viewModel.imageData,
               let image = Image(data: imageData) {
                createSelectedImageBox(selected, image: image)
            }
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                createToolbarLikeButton()
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - UI creation methods

private extension RegionDetailView {
    func createTitleLabel() -> some View {
        Text(viewModel.getRegionTitle())
            .font(
                .system(size: Constant.titleLabelFontSize, weight: .bold)
            )
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
    
    func createViewCountLabel() -> some View {
        Text(viewModel.getViewCount())
            .font(
                .system(
                    size: Constant.viewCountLabelFontSize,
                    weight: .regular
                )
            )
    }
    
    func createImageGrid() -> some View {
        LazyVGrid(
            columns: [
                GridItem(.fixed(Constant.gridItemSize)),
                GridItem(.fixed(Constant.gridItemSize))
            ],
            spacing: Constant.itemSpacing
        ) {
            ForEach(viewModel.imageBoxDataSource, id: \.id) { imageBox in
                configureImageBox(imageBox)
            }
        }
    }
    
    func configureImageBox(_ imageBox: ImageBox) -> some View {
        imageBox
            .matchedGeometryEffect(
                id: imageBox.id,
                in: namespace,
                isSource: selectedImageBox == nil
            )
            .zIndex(
                selectedImageBox == imageBox
                    ? Constant.imageZIndexSelected
                    : Constant.imageZIndexNotSelected
            )
            .onTapGesture {
                guard !imageBox.viewModel.isLoading else {
                    return
                }
                position = .zero
                withAnimation(Constant.imageSelectAnimation) {
                    selectedImageBox = imageBox
                }
            }
    }
    
    func createSelectedImageOverlay() -> some View {
        Color(UIColor.systemBackground)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .opacity(
                selectedImageBox == nil
                    ? Constant.nothingSelectedColorOpacity
                    : viewModel.colorOpacity(for: position)
            )
    }
    
    func createSelectedImageBox(_ selected: ImageBox, image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(Constant.imageAspectRatio, contentMode: .fit)
            .matchedGeometryEffect(
                id: selected.id,
                in: namespace,
                isSource: selectedImageBox != nil
            )
            .zIndex(Constant.imageZIndexTop)
            .onTapGesture {
                withAnimation(Constant.imageSelectAnimation) {
                    selectedImageBox = nil
                }
            }
            .offset(position)
            .gesture(
                DragGesture()
                    .onChanged {
                        position = $0.translation
                    }.onEnded { _ in
                        withAnimation(Constant.imageSelectAnimation) {
                            if Constant.imageDropHeight < abs(position.height) {
                                selectedImageBox = nil
                            } else {
                                position = .zero
                            }
                        }
                    }
            )
    }
    
    func createToolbarLikeButton() -> some View {
        LikeButton(
            viewModel: viewModel.createLikeButtonViewModel()
        ).frame(
            width: Constant.likeButtonWidth,
            height: Constant.likeButtonHeight
        ).foregroundStyle(Color.primary)
    }
}
