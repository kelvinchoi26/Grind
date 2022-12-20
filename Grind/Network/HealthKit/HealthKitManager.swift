//
//  HealthKit.swift
//  Grind
//
//  Created by 최형민 on 2022/09/16.
//

import HealthKit
import UIKit

final class HealthKitManager {
    
    private init() {}
    
    var completionHandler: ((Int) -> ())?
    
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
    
    func fetchEnergyBurned(date: Date, completion: @escaping (Int?) -> Void) {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("활동칼로리를 불러오는데 실패했습니다")
            // query 실행이 정상적으로 안되는 경우 1000으로 기본 설정
            return
        }
        
        var components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let startDate = Calendar.current.date(from: components)
        
        components.day = (components.day ?? 0) + 1
        let endDate = Calendar.current.date(from: components)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: HKQueryOptions.strictEndDate)
        
        var dailyCalorie: Double = 0
        
        let query = HKSampleQuery.init(sampleType: sampleType,
                                       predicate: predicate,
                                       limit: 0,
                                       sortDescriptors: nil) { (query, results, error) in
            guard results != nil else {
                print("활동칼로리 데이터를 불러오는데 실패했습니다.")
                return
            }
            
            for activity in results as! [HKQuantitySample]
            {
                dailyCalorie += activity.quantity.doubleValue(for: HKUnit.kilocalorie())
            }
            
            if dailyCalorie != 0 {
                completion(Int(dailyCalorie))
            } else {
                completion(1000)
            }
        }
        
        HealthKitManager.healthStore.execute(query)
        
    }
    
}
