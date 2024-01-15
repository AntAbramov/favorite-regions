//
//  RegionDetailViewModel.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 15.01.2024.
//

import Foundation

// MARK: - Constant

private enum Constant {
    static let opacityDenominator: Double = 800
    static let viewsString = "Просмотров: "
}

// MARK: - Implementation

final class RegionDetailViewModel: ObservableObject {
    // MARK: Property
    private let dto: RegionDTO
    
    // MARK: Dependency
    private let imageLoader: DataLoader
    
    // MARK: Data Source
    let imageBoxDataSource: [ImageBox]
    
    // MARK: init
    init(
        dto: RegionDTO,
        imageLoader: DataLoader
    ) {
        self.dto = dto
        self.imageLoader = imageLoader
        
        self.imageBoxDataSource = dto.thumbUrls.map { url in
            let viewModel = ImageBoxViewModel(
                imageUrl: url,
                imageLoader: imageLoader
            )
            return ImageBox(viewModel: viewModel)
        }
    }
}

// MARK: - Interface

extension RegionDetailViewModel {
    func colorOpacity(for position: CGSize) -> Double {
        min(1, max(0, 1 - abs(Double(position.height) / Constant.opacityDenominator)))
    }
    
    func createLikeButtonViewModel() -> LikeButtonViewModel {
        .init(brandId: dto.brandId)
    }
    
    func getRegionTitle() -> String {
        dto.title
    }
    
    func getViewCount() -> String {
        Constant.viewsString + "\(dto.viewsCount)"
    }
}

// MARK: - Private Methods

private extension RegionDetailViewModel {
    func createImageBoxes() -> [ImageBox] {
        dto.thumbUrls.map { url in
            let viewModel = ImageBoxViewModel(
                imageUrl: url,
                imageLoader: imageLoader
            )
            return ImageBox(viewModel: viewModel)
        }
    }
}
