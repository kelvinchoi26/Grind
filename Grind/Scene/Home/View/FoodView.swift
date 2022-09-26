//
//  FoodView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/27.
//

import UIKit

final class FoodView: BaseView {
    
    let imageView = UIImageView()
    let nutritionLabel = UILabel()
    let calorieView = FoodCalorieView()
    let carbView = FoodCalorieView()
    let proteinView = FoodCalorieView()
    let fatView = FoodCalorieView()
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = .clear
        
        imageView.do {
            $0.contentMode = .scaleToFill
        }
        
        nutritionLabel.do {
            $0.font = Constants.Font.subTitleFont
            $0.textColor = Constants.Color.primaryText
        }
        
        calorieView.do {
            $0.calorieLabel.text = "총 칼로리"
            $0.calorieTextField.placeholder = "입력"
        }
        
        carbView.do {
            $0.calorieLabel.text = "탄수화물"
            $0.calorieTextField.placeholder = "입력"
        }
        
        proteinView.do {
            $0.calorieLabel.text = "단백질"
            $0.calorieTextField.placeholder = "입력"
        }
        
        fatView.do {
            $0.calorieLabel.text = "지방"
            $0.calorieTextField.placeholder = "입력"
        }
        
        [imageView, calorieView, carbView, proteinView, fatView].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        let spacing = 20
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            $0.height.equalTo(300)
        }
        
        nutritionLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(spacing)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(spacing)
        }
        
        calorieView.snp.makeConstraints {
            $0.top.equalTo(nutritionLabel.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide)
        }
        
        carbView.snp.makeConstraints {
            $0.centerY.equalTo(calorieView)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        proteinView.snp.makeConstraints {
            $0.top.equalTo(calorieView.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        fatView.snp.makeConstraints {
            $0.top.equalTo(carbView.snp.bottom)
            $0.trailing.equalToSuperview()
        }
        
    }
}

