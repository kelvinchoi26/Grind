//
//  DailyRecordRepository.swift
//  Grind
//
//  Created by 최형민 on 2022/09/20.
//

import RealmSwift

final class DailyRecordRepository {
    
    private init() { }
    
    static let repository = DailyRecordRepository()
    
    private let localRealm = try! Realm()
    
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
    
//    func fetch(by date: Date) -> DailyRecord {
//            return localRealm.objects(Diary.self).filter("diaryDate >= %@ AND diaryDate < %@", date, Date(timeInterval: 86400, since: date))
//    }
}
