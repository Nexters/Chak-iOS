//
//  DefaultPhotoClusterService.swift
//  Chac
//
//  Created by 이원빈 on 1/24/26.
//

import Foundation

final class DefaultPhotoClusterService: PhotoClusterService {
    func clusterPhotos(_ photos: [PhotoAsset]) -> [PhotoCluster] {
        // FIXME: 실제 클러스터 로직 구현필요
        return [ // mock data
            .init(id: UUID(), title: "Jeju Trip", photoAssets: photos),
            .init(id: UUID(), title: "Jeju Trip2", photoAssets: photos),
            .init(id: UUID(), title: "Jeju Trip3", photoAssets: photos),
            .init(id: UUID(), title: "Jeju Trip4", photoAssets: photos),
            .init(id: UUID(), title: "Jeju Trip5", photoAssets: photos)
        ]
    }
}
