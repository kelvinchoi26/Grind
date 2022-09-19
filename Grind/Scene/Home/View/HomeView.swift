//
//  HomeCollectionViewCell.swift
//  Grind
//
//  Created by 최형민 on 2022/09/15.
//

import UIKit
import SnapKit
import Then

final class HomeView: BaseView {
    
    let adviceView = HomeAdviceView()
    let weightView = HomeWeightView()
    let calorieView = HomeCalorieView()
    let workoutView = HomeWorkoutView()
    
    override func configureUI() {
        self.backgroundColor = .clear
        
        weightView.do {
            $0.todayWeightView.cellTitle.text = "오늘의 체중"
            $0.todayWeightView.cellContent.text = "70.4kg"
            $0.WeightDiffView.cellTitle.text = "체중 변화"
            $0.WeightDiffView.cellContent.text = "+0.2kg"
        }
        
        calorieView.do {
            $0.calorieConsumed.cellTitle.text = "섭취 칼로리"
            $0.calorieConsumed.cellContent.text = "2150"
            $0.calorieSurplus.cellTitle.text = "잉여 칼로리"
            $0.calorieSurplus.cellContent.text = "-500"
            $0.calorieBurned.cellTitle.text = "활동 칼로리"
            $0.calorieBurned.cellContent.text = "1000"
        }
        
        [adviceView, weightView, calorieView, workoutView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        adviceView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(20)
        }
        
        weightView.snp.makeConstraints {
            $0.top.equalTo(adviceView.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        
        calorieView.snp.makeConstraints {
            $0.top.equalTo(weightView.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        
        workoutView.snp.makeConstraints {
            $0.top.equalTo(calorieView.snp.bottom)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(20)
        }
    }
}
