//
//  HomeCollectionViewCell.swift
//  Grind
//
//  Created by 최형민 on 2022/09/15.
//

import UIKit
import SnapKit
import Then
import FSCalendar

final class HomeView: BaseView {
    
    lazy var calendar = FSCalendar()
    
    var selectedDate: Date = Date()
    
    let adviceView = HomeAdviceView()
    let weightView = HomeWeightView()
    let calorieView = HomeCalorieView()
    let workoutView = HomeWorkoutView()
    
    override func configureUI() {
        self.backgroundColor = .clear
        
        calendar.do {
            $0.backgroundColor = Constants.Color.backgroundColor
            
            $0.locale = Locale(identifier: "ko_KR")
            $0.firstWeekday = 2
            $0.select(Date())
            $0.appearance.headerTitleFont = Constants.Font.subTitleFont
            $0.appearance.headerTitleColor = Constants.Color.primaryText
            $0.appearance.headerTitleAlignment = .center
            $0.appearance.headerDateFormat = "YYYY년 MM월"
            $0.appearance.titleFont = Constants.Font.subTitleFont
            $0.appearance.weekdayFont = Constants.Font.textFont
            $0.appearance.weekdayTextColor = Constants.Color.primaryText
            $0.appearance.todaySelectionColor = Constants.Color.accentColor
            $0.appearance.titleSelectionColor = Constants.Color.primaryText
            $0.appearance.selectionColor = Constants.Color.accentColor
            
            // 양옆 년도, 월 지우기
            $0.appearance.headerMinimumDissolvedAlpha = 0.0
            
            $0.calendarWeekdayView.weekdayLabels[0].text = "일"
            $0.calendarWeekdayView.weekdayLabels[1].text = "월"
            $0.calendarWeekdayView.weekdayLabels[2].text = "화"
            $0.calendarWeekdayView.weekdayLabels[3].text = "수"
            $0.calendarWeekdayView.weekdayLabels[4].text = "목"
            $0.calendarWeekdayView.weekdayLabels[5].text = "금"
            $0.calendarWeekdayView.weekdayLabels[6].text = "토"
            
            $0.scope = .week
            $0.isHidden = true
        }
        
        weightView.do {
            $0.todayWeightView.cellTitle.text = "오늘의 체중"
        }
        
        calorieView.do {
            $0.calorieConsumed.cellTitle.text = "섭취 칼로리"
            $0.calorieSurplus.cellTitle.text = "잉여 칼로리"
            $0.calorieBurned.cellTitle.text = "활동 칼로리"
        }
        
        [calendar, adviceView, weightView, calorieView, workoutView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        let spacing = 20
        
        calendar.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(300)
        }
        
        adviceView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(spacing)
        }
        
        weightView.snp.makeConstraints {
            $0.top.equalTo(adviceView.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(spacing)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        
        calorieView.snp.makeConstraints {
            $0.top.equalTo(weightView.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(spacing)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        
        workoutView.snp.makeConstraints {
            $0.top.equalTo(calorieView.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(spacing)
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
    }
}





