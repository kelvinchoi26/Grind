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

    // 접근 권한 허용 요청
    func requestAuthorization() {
        HealthKitManager.healthStore.requestAuthorization(toShare: nil, read: allTypes) { (success, error) in
            guard success else {
                print("HealthKit 인증 오류 발생")
                return
            }
            
            print("HealthKit 인증 성공")
        }
    }
    
    // 접근 권한 확인
    func checkAuthorization() {
        guard !HKHealthStore.isHealthDataAvailable() else {
            requestAuthorization()
            return
        }
        print("권한 승인 되어있음")
    }
    
    func fetchEnergyBurned() {
        let sampleType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)
        
        let today = Date()
        let startDate = Calendar.current.date(byAdding: .month, value: -3, to: today)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: today, options: HKQueryOptions.strictEndDate)
        
        let query = HKSampleQuery.init(sampleType: sampleType!,
                                       predicate: predicate,
                                       limit: HKObjectQueryNoLimit,
                                       sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (query, results, error) in
                                        print(results)
        }
        
        HealthKitManager.healthStore.execute(query)
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
