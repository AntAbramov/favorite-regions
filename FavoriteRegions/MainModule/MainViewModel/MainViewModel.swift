//
//  MainViewModel.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

// MARK: - Implementation

final class MainViewModel: ObservableObject {
    // MARK: Dependency
    private let networkService: NetworkService
    
    // MARK: @Published
    @Published private(set) var dataSource: [RegionDTO] = []
    @Published private(set) var isRefreshing = true
    @Published var hasError = false
    
    // MARK: init
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
}

// MARK: - Interface

extension MainViewModel {
    func createRegionTableCellViewModel(
        dto: RegionDTO
    ) -> RegionTableCellViewModel {
        .init(dto: dto, imageLoader: networkService)
    }
}

// MARK: - Networking methods

extension MainViewModel {
    func performRequest() {
        Task(priority: .userInitiated) {
            do {
                let brands = try await networkService.fetchBrands()
                await MainActor.run {
                    dataSource = brands.prepareDTO()
                    isRefreshing = false
                }
            } catch let error as NetworkError {
                await MainActor.run {
                    hasError = true
                }
                LoggingService.shared.networkError(error)
            } catch {
                await MainActor.run {
                    hasError = true
                }
                LoggingService.shared.unknownNetworkError(error)
            }
        }
    }
    
    func refresh() async {
        do {
            let brands = try await networkService.fetchBrands()
            await MainActor.run {
                dataSource = brands.prepareDTO()
            }
        } catch let error as NetworkError {
            LoggingService.shared.networkError(error)
        } catch {
            LoggingService.shared.unknownNetworkError(error)
        }
    }
    
    func retryRequest() {
        performRequest()
    }
}

// MARK: - Route methods

extension MainViewModel {
    func showDetailView(dto: RegionDTO) {
        Router.shared.showRegionDetail(dto)
    }
}
