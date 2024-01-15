//
//  ImageBoxViewModel.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 15.01.2024.
//

import Foundation

// MARK: - Implementation

final class ImageBoxViewModel: ObservableObject {
    // MARK: Dependency
    private let imageLoader: DataLoader
    
    // MARK: Property
    private let imageUrl: URL
    private(set) var imageData: Data?
    
    // MARK: @Published
    @Published var isLoading = true
    
    // MARK: init
    init(
        imageUrl: URL,
        imageLoader: DataLoader
    ) {
        self.imageUrl = imageUrl
        self.imageLoader = imageLoader
        loadImage()
    }
}

// MARK: - Private methods

private extension ImageBoxViewModel {
    func loadImage() {
        Task(priority: .userInitiated) {
            do {
                imageData = try await imageLoader.downloadData(from: imageUrl)
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
