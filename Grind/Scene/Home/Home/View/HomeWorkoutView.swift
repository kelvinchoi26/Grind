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
    let cameraButton = UIButton()
    let imageView = UIImageView()
    
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
            $0.font = Constants.Font.subTitleFont
            $0.placeholder = "오늘은 어느 부위 운동을 하셨나요?"
            $0.textAlignment = .center
            $0.textColor = Constants.Color.primaryText
        }
        
        workoutTimeTextField.do {
            $0.font = Constants.Font.subTitleFont
            $0.placeholder = "몇 분 동안 진행하셨나요?"
            $0.textAlignment = .center
            $0.textColor = Constants.Color.primaryText
        }
        
        cameraButton.do {
            $0.setImage(UIImage(systemName: "photo.fill.on.rectangle.fill"), for: .normal)
            $0.tintColor = Constants.Color.primaryText
        }
        
        imageView.do {
            $0.alpha = 0.3
            $0.contentMode = .scaleToFill
        }
        
        [todayWorkoutLabel, todayWorkoutTextField, workoutTimeTextField, cameraButton, imageView].forEach {
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
        
        cameraButton.snp.makeConstraints {
            $0.top.trailing.equalTo(imageView).inset(10)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }

    }
    
}
