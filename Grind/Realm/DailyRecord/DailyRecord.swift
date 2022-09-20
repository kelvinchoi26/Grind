//
//  RealmModel.swift
//  Grind
//
//  Created by 최형민 on 2022/09/13.
//

import Foundation
import RealmSwift

final class DailyRecord: Object {
    @Persisted var date = Date() // 날짜(필수)
    @Persisted var weight: Double? // 체중(옵션)
    @Persisted var caloriesBurned: Int? // 활동칼로리(옵션)
    @Persisted var caloriesConsumed: Int? // 섭취칼로리(옵션)
    @Persisted var photo: String? // 이미지 이름(옵션)
    @Persisted var workout: String? // 운동 부위(옵션)
    @Persisted var didWorkout: Bool // 운동 여부(필수, 기본값: False)
    @Persisted var condition: Int? // 컨디션 이모티콘(옵션) 0: 기본, 1: 우울, 2: 신남
    
    // PK(필수): 타입: Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(date: Date, weight: Double?, caloriesBurned: Int?, caloriesConsumed: Int?, photo: String?, workout: String?, didWorkout: Bool, condition: Int?) {
        self.init()
        self.date = date
        self.weight = weight
        self.caloriesBurned = caloriesBurned
        self.caloriesConsumed = caloriesConsumed
        self.photo = photo
        self.workout = workout
        self.didWorkout = false
        self.condition = condition
    }
}
