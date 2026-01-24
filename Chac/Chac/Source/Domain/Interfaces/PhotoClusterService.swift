//
//  PhotoClusterService.swift
//  Chac
//
//  Created by 이원빈 on 1/24/26.
//

import Foundation

protocol PhotoClusterService {
    func clusterPhotos(_ photos: [PhotoAsset]) -> [PhotoCluster]
}
