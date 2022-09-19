//
//  HealthKitSetupError.swift
//  Grind
//
//  Created by 최형민 on 2022/09/16.
//

enum HealthKitSetupError: Error {
    case notAvailableonDevice
    case dataTypeNotAvailable
    case authorizationFailed
}
