//
//  TimeClusteringService.swift
//  Chac
//
//  Created by 가은 on 1/24/26.
//

import Photos

/// 시간 간격을 기반으로 사진을 그룹화
final class TimeClusteringService: StreamingStrategy {
    var minClusterSize: Int
    private let interval: TimeInterval
    
    /// - Parameters:
    ///   - minClusterSize: 유효한 클러스터가 되기 위한 최소 개수 (기본 20개)
    ///   - interval: 인접한 시간 간에 허용되는 최대 시간 간격(초 단위), 기본값은 10,800초(3시간)
    init(minClusterSize: Int = 20, interval: TimeInterval = 10800) {
        self.minClusterSize = minClusterSize
        self.interval = interval
    }
    
    func cluster(assets: [PHAsset]) -> AsyncStream<[PHAsset]> {
        AsyncStream { continuation in
            guard !assets.isEmpty else {
                continuation.finish()
                return
            }
            
            var currentCluster: [PHAsset] = [assets[0]]
            
            for i in 1..<assets.count {
                let previousAsset = assets[i-1]
                let currentAsset = assets[i]
                
                guard let curAssetDate = currentAsset.creationDate,
                      let prevAssetDate = previousAsset.creationDate else { continue }
                
                // 시간 차이가 임계값(3시간) 이내인지 확인
                if prevAssetDate.timeIntervalSince(curAssetDate) <= interval {
                    currentCluster.append(currentAsset)
                } else {
                    // 임계값을 초과하면, 즉시 yield로 방출
                    if currentCluster.count >= minClusterSize {
                        continuation.yield(currentCluster)
                    }
                    
                    // 새로운 그룹 시작
                    currentCluster = [currentAsset]
                }
            }
            
            // 루프 종료 후 마지막 그룹 처리 및 방출
            if currentCluster.count >= minClusterSize {
                continuation.yield(currentCluster)
            }
            
            continuation.finish()
        }
        
    }
}

