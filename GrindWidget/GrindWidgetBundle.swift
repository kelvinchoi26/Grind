//
//  GrindWidgetBundle.swift
//  GrindWidget
//
//  Created by 최형민 on 2023/05/19.
//

import WidgetKit
import SwiftUI

@main
struct GrindWidgetBundle: WidgetBundle {
    var body: some Widget {
        GrindWidget()
        GrindWidgetLiveActivity()
    }
}
