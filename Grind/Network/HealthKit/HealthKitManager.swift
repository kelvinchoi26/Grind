//
//  HealthKit.swift
//  Grind
//
//  Created by 최형민 on 2022/09/16.
//

import HealthKit

protocol HealthStoreProtocol {
    func requestAuthorization(completion: @escaping (Bool,Error?) -> Void)
}

final class HealthKitManager {
    
    private init() {}
    
    // Singleton
    static let shared = HealthKitManager()
    
}
