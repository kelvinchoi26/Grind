////
////  Food.swift
////  Grind
////
////  Created by 최형민 on 2022/09/15.
////
//
//import Foundation
//import RealmSwift
//import UIKit
//
//class Food: Object {
//    @Persisted var calorie: Int // 1인분 당 칼로리(필수)
//    @Persisted var carb: Int // 1인분 당 칼로리(필수)
//    @Persisted var protein: Int // 1인분 당 칼로리(필수)
//    @Persisted var fat: Int // 1인분 당 칼로리(필수)
//    @Persisted var name: String // 상품명/음식명(필수)
//    
//    // PK(필수): 타입: Int, UUID, ObjectID
//    @Persisted(primaryKey: true) var objectId: ObjectId
//    
//    convenience init(calorie: Int, carb: Int, protein: Int, fat: Int, name: String) {
//        self.init()
//        self.calorie = calorie
//        self.carb = carb
//        self.protein = protein
//        self.fat = fat
//        self.name = name
//    }
//}
