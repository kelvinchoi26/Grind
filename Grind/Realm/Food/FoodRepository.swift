////
////  FoodRepository.swift
////  Grind
////
////  Created by 최형민 on 2022/09/27.
////
//
//import RealmSwift
//import Foundation
//
//protocol FoodRepositoryType {
//    
//}
//
//final class FoodRepository: FoodRepositoryType {
//
//    private init() { }
//
//    static let repository = FoodRepository()
//
//    private let localRealm = try! Realm()
//
//    var count: Int {
//        return localRealm.objects(Food.self).count
//    }
//
//    func printFileLocation() {
//        print("Realm is located at:", localRealm.configuration.fileURL!)
//    }
//
//    func addFood(item: Food) {
//        do {
//            try localRealm.write {
//                localRealm.add(item)
//            }
//        } catch {
//            print(error)
//        }
//    }
//
////    func fetch() -> Results<Food> {
////        return localRealm.objects(DailyRecord.self).sorted(byKeyPath: "date", ascending: true)
////    }
//
//    func fetch(by date: Date) -> Results<DailyRecord> {
//        return localRealm.objects(DailyRecord.self).filter("date >= %@ AND date < %@", date, Date(timeInterval: 86400, since: date))
//    }
//
//}
