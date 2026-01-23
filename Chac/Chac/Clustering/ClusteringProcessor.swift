//
//  ClusteringProcessor.swift
//  Chac
//
//  Created by 가은 on 1/24/26.
//

import Foundation

final class ClusteringProcessor {
    private let timeService: ClusteringStrategy
    private let locationService: ClusteringStrategy
    
    init(
        timeService: ClusteringStrategy = TimeClusteringService(),
        locationService: ClusteringStrategy = LocationClusteringService()
    ) {
        self.timeService = timeService
        self.locationService = locationService
    }
    
    /// 두 가지 전략을 순차적으로 적용하여 최종 클러스터를 생성합니다
    func process(assets: [PhotoAsset]) async -> [[PhotoAsset]] {
        // 시간으로 그룹화
        let timeGroups = await timeService.cluster(assets: assets)
        
        // 장소로 다시 그룹화 
        var finalResult: [[PhotoAsset]] = []
        for group in timeGroups {
            let locationGroups = await locationService.cluster(assets: group)
            finalResult.append(contentsOf: locationGroups)
        }
        
        return finalResult
    }
}
