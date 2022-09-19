//
//  HomeWorkoutView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/19.
//

import UIKit

final class HomeWorkoutView: BaseView {
    
    let todayWorkoutLabel = UILabel()
    let todayWorkoutTextField = UITextField()
    let workoutTimeTextField = UITextField()
    let workoutEmoji = UIButton()
    
    override func configureUI() {
        super.configureUI()
        
        self.layer.borderWidth = Constants.Design.borderWidth
        self.layer.borderColor = Constants.Color.borderColor
        
        todayWorkoutLabel.do {
            $0.font = Constants.Font.subTitleFont
            $0.text = "오늘의 운동"
            $0.textAlignment = .center
            $0.textColor = Constants.Color.primaryText
        }
        
        todayWorkoutTextField.do {
            $0.font = Constants.Font.textFont
            $0.placeholder = "오늘은 어느 부위 운동을 하셨나요?"
            $0.textAlignment = .center
            $0.textColor = Constants.Color.primaryText
        }
        
        workoutTimeTextField.do {
            $0.font = Constants.Font.textFont
            $0.placeholder = "몇 분 동안 진행하셨나요?"
            $0.textAlignment = .center
            $0.textColor = Constants.Color.primaryText
        }
        
        workoutEmoji.do {
            $0.setImage(UIImage(systemName: "face.smiling"), for: .normal)
            $0.tintColor = Constants.Color.emojiColor
        }
        
        [todayWorkoutLabel, todayWorkoutTextField, workoutTimeTextField, workoutEmoji].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        todayWorkoutLabel.snp.makeConstraints {
            $0.top.equalTo(self).inset(10)
            $0.centerX.equalTo(self)
        }
        
        todayWorkoutTextField.snp.makeConstraints {
            $0.top.equalTo(todayWorkoutLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(self)
        }
        
        workoutTimeTextField.snp.makeConstraints {
            $0.top.equalTo(todayWorkoutTextField.snp.bottom).offset(10)
            $0.centerX.equalTo(self)
        }
        
        workoutEmoji.snp.makeConstraints {
            $0.height.equalTo(self).multipliedBy(0.3)
            $0.bottom.equalTo(self).inset(10)
            $0.centerX.equalTo(self)
        }
    }
    
}
