//
//  RealmModel.swift
//  Grind
//
//  Created by 최형민 on 2022/09/13.
//

import Foundation
import RealmSwift

class DailyRecord: Object {
    @Persisted var date = Date() // 날짜(필수)
    @Persisted var weight: Double? // 체중(옵션)
    @Persisted var caloriesBurned: Int // 활동칼로리(옵션)
    @Persisted var caloriesConsumed: Int // 섭취칼로리(옵션)
    @Persisted var didWorkout: Bool // 운동 여부(필수, 기본값: False)
    @Persisted var workoutRoutine: String? // 운동 부위(옵션)
    @Persisted var workoutTime: String? // 운동 시간(옵션)
    @Persisted var food: List<Food> // 음식
    
    // PK(필수): 타입: Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(date: Date, weight: Double?, caloriesBurned: Int, caloriesConsumed: Int, didWorkout: Bool, workoutRoutine: String?, workoutTime: String?, food: List<Food>) {
        self.init()
        self.date = date
        self.weight = weight
        self.caloriesBurned = caloriesBurned
        self.caloriesConsumed = caloriesConsumed
        self.didWorkout = false
        self.workoutRoutine = workoutRoutine
        self.workoutTime = workoutTime
        self.food = food
    }
}
