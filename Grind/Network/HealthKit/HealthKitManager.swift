//
//  HealthKit.swift
//  Grind
//
//  Created by 최형민 on 2022/09/16.
//

import HealthKit

protocol HealthStoreProtocol {

}

final class HealthKitManager {
    
    private init() {}
    
    // Singleton
    static let shared = HealthKitManager()
    
    static let healthStore = HKHealthStore()
    
    private let allTypes = Set([HKObjectType.workoutType(),
                        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])

    func requestAuthorization() {
        HealthKitManager.healthStore.requestAuthorization(toShare: nil, read: allTypes) { (success, error) in
            guard success else {
                print("HealthKit 인증 오류 발생")
                return
            }
            
            print("HealthKit 인증 성공")
        }
    }
    
    func checkAuthorization() {
        guard !HKHealthStore.isHealthDataAvailable() else {
            requestAuthorization()
            return
        }
        print("권한 승인 되어있음")
    }
    
//    func updateCalorieBurned() -> HKObjectType {
//        guard HKHealthStore.isHealthDataAvailable() else {
//            requestAuthorization()
//            return
//        }
//        
////        return healthStore.
//    }
}
