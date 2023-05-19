//
//  Date+Extension.swift
//  Grind
//
//  Created by 최형민 on 2023/05/19.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
