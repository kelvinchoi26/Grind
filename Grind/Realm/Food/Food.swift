//
//  Food.swift
//  Grind
//
//  Created by 최형민 on 2022/09/15.
//

import Foundation
import RealmSwift

class Food: Object {
    @Persisted var calorie: Int // 1인분 당 칼로리(필수)
    @Persisted var unit: Int // 단위(필수), ex. 개수, 그램 수
    @Persisted var name: String // 상품명/음식명(필수)
    
    // PK(필수): 타입: Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(calorie: Int, unit: Int, name: String) {
        self.init()
        self.calorie = calorie
        self.unit = unit
        self.name = name
    }
}
