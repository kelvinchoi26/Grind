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
    func editWorkoutRoutine(item: Results<DailyRecord>, routine: String)
    func editWorkoutTime(item: Results<DailyRecord>, time: String)
    func editWeightCalorie(item: Results<DailyRecord>, weight: String, calorie: String)
    func changeWeight(item: DailyRecord, updatedWeight: Double)
    func addFood(item: DailyRecord, food: Food, addedCalorie: Int)
    func deleteFood(item: DailyRecord, food: Food, deletedCalorie: Int)
    func updateCalorieBurned(item: Results<DailyRecord>, updatedCalorie: Int)
    func fetch() -> Results<DailyRecord>
    func fetch(by date: Date) -> Results<DailyRecord>
}

final class DailyRecordRepository: DailyRecordRepositoryType {
    
    private init() { }
    
    static let repository = DailyRecordRepository()
    
    private let localRealm = try! Realm()
    
    var count: Int {
        return localRealm.objects(DailyRecord.self).count
    }
    
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
    
    func editWorkoutRoutine(item: Results<DailyRecord>, routine: String) {
        do {
            try localRealm.write {
                item[0].workoutRoutine = routine
            }
        } catch {
            print(error)
        }
    }
    
    func editWorkoutTime(item: Results<DailyRecord>, time: String) {
        do {
            try localRealm.write {
                item[0].workoutTime = time
            }
        } catch {
            print(error)
        }
    }
    
    func editWeightCalorie(item: Results<DailyRecord>, weight: String, calorie: String) {
        do {
            try localRealm.write {
                item[0].weight = Double(weight)
                item[0].caloriesConsumed = Int(calorie) ?? 0
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
    
    // 식단 영양정보 추가
    func addFood(item: DailyRecord, food: Food, addedCalorie: Int) {
        do {
            try localRealm.write {
                item.caloriesConsumed += addedCalorie
                item.food.append(food)
            }
        } catch {
            print(error)
        }
    }
    
    // 식단 영양정보 삭제
    func deleteFood(item: DailyRecord, food: Food, deletedCalorie: Int) {
        do {
            try localRealm.write {
                item.caloriesConsumed -= deletedCalorie
                item.food.realm?.delete(food)
            }
        } catch {
            print(error)
        }
    }
    
    // 활동칼로리가 업데이트 될 때 마다 실행
    func updateCalorieBurned(item: Results<DailyRecord>, updatedCalorie: Int) {
        do {
            try localRealm.write {
                item[0].caloriesBurned = updatedCalorie
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
