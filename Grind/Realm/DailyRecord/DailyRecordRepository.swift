//
//  DailyRecordRepository.swift
//  Grind
//
//  Created by 최형민 on 2022/09/20.
//

import RealmSwift
import Foundation

protocol DailyRecordRepositoryType {
    func printFileLocation()
    func addRecord(item: DailyRecord)
    func changeWeight(item: DailyRecord, updatedWeight: Double)
    func updateCalorieConsumed(item: DailyRecord, updatedCalorie: Int)
    func updateCalorieBurned(item: DailyRecord, updatedCalorie: Int)
}

final class DailyRecordRepository: DailyRecordRepositoryType {
    
    private init() { }
    
    static let repository = DailyRecordRepository()
    
    private let localRealm = try! Realm()
    
    func printFileLocation() {
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    func addRecord(item: DailyRecord) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    // 오늘의 체중이 변화할 때 마다 실행
    func changeWeight(item: DailyRecord, updatedWeight: Double) {
        do {
            try localRealm.write {
                item.weight = updatedWeight
            }
        } catch {
            print(error)
        }
    }
    
    // 섭취칼로리에 음식 입력할 때 마다 실행
    func updateCalorieConsumed(item: DailyRecord, updatedCalorie: Int) {
        do {
            try localRealm.write {
                item.caloriesConsumed = updatedCalorie
            }
        } catch {
            print(error)
        }
    }
    
    // 활동칼로리가 업데이트 될 때 마다 실행
    func updateCalorieBurned(item: DailyRecord, updatedCalorie: Int) {
        do {
            try localRealm.write {
                item.caloriesBurned = updatedCalorie
            }
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<DailyRecord> {
        return localRealm.objects(DailyRecord.self).sorted(byKeyPath: "date", ascending: true)
    }
    
    func fetch(by date: Date) -> Results<DailyRecord> {
        return localRealm.objects(DailyRecord.self).filter("date >= %@ AND date < %@", date, Date(timeInterval: 86400, since: date))
    }
   
}
