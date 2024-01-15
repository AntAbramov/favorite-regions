//
//  RegionTableCellViewModel.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

// MARK: - Constant

final class RegionTableCellViewModel: ObservableObject {
    // MARK: Property
    private let title: String
    private let brandId: String
    private(set) var imageData: Data?
    
    // MARK: Dependency
    private let imageLoader: DataLoader

    // MARK: @Published
    @Published var isLoading = true
    
    // MARK: init
    init(
        dto: RegionDTO,
        imageLoader: DataLoader
    ) {
        self.title = dto.title
        self.brandId = dto.brandId
        self.imageLoader = imageLoader
        
        if let url = dto.thumbUrls.first {
            downloadImage(with: url)
        } else {
            self.isLoading = false
        }
    }
}

// MARK: - Interface

extension RegionTableCellViewModel {
    func createLikeButtonViewModel() -> LikeButtonViewModel {
        .init(brandId: brandId)
    }
    
    func createRegionTitleViewModel() -> RegionTitleViewModel {
        .init(title: title)
    }
}

// MARK: - Networking methods

private extension RegionTableCellViewModel {
    func downloadImage(with url: URL) {
        Task(priority: .userInitiated) {
            do {
                imageData = try await imageLoader.downloadData(from: url)
                await MainActor.run {
                    isLoading = false
                }
            } catch let error as NetworkError {
                LoggingService.shared.networkError(error)
            } catch {
                LoggingService.shared.unknownNetworkError(error)
            }
        }
    }
}
