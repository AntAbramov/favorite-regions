//
//  LikeButtonViewModel.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Combine

// MARK: - Implementation

final class LikeButtonViewModel: ObservableObject {
    // MARK: Property
    private var bag = Set<AnyCancellable>()
    private let brandId: String
    
    // MARK: @Published
    @Published var isFollowed: Bool
    
    // MARK: Init
    init(brandId: String) {
        self.brandId = brandId
        self.isFollowed = FollowingRegions.shared.fetch(for: brandId)
        subscribe()
    }
}

// MARK: - Interface

extension LikeButtonViewModel {
    func likeButtonTapped() {
        FollowingRegions.shared.set(value: !isFollowed, for: brandId)
    }
}

// MARK: - Private methods

private extension LikeButtonViewModel {
    // To update following state
    func subscribe() {
        FollowingRegions.shared.$valueChanged
            .sink { [weak self] _ in
                guard let self else {
                    return
                }
                isFollowed = FollowingRegions.shared.fetch(for: brandId)
            }.store(in: &bag)
    }
}
