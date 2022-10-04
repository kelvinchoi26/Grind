//
//  FoodView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/27.
//

import UIKit

final class FoodView: BaseView {
    
    let imageView = UIImageView()
    let cameraButton = UIButton()
    let nutritionLabel = UILabel()
    let foodNameView = FoodCalorieView()
    let calorieView = FoodCalorieView()
    let carbView = FoodCalorieView()
    let proteinView = FoodCalorieView()
    let fatView = FoodCalorieView()
    let unitLabel = UILabel()
    let addButton = UIButton()
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = Constants.Color.backgroundColor
        
        imageView.do {
            $0.contentMode = .scaleToFill
            $0.layer.borderColor = Constants.Color.borderColor
            $0.layer.borderWidth = Constants.Design.borderWidth
        }
        
        cameraButton.do {
            $0.setImage(UIImage(systemName: "photo.fill.on.rectangle.fill"), for: .normal)
            $0.tintColor = Constants.Color.primaryText
        }
        
        foodNameView.do {
            $0.calorieLabel.text = "음식 이름"
            $0.calorieTextField.placeholder = "입력"
        }
        
        nutritionLabel.do {
            $0.font = Constants.Font.titleFont
            $0.textColor = Constants.Color.primaryText
            $0.text = "영양정보 입력"
        }
        
        calorieView.do {
            $0.calorieLabel.text = "총 칼로리"
            $0.calorieTextField.placeholder = "입력"
            $0.calorieTextField.keyboardType = .decimalPad
        }
        
        carbView.do {
            $0.calorieLabel.text = "탄수화물"
            $0.calorieTextField.placeholder = "입력"
            $0.calorieTextField.keyboardType = .decimalPad
        }
        
        proteinView.do {
            $0.calorieLabel.text = "단백질"
            $0.calorieTextField.placeholder = "입력"
            $0.calorieTextField.keyboardType = .decimalPad
        }
        
        fatView.do {
            $0.calorieLabel.text = "지방"
            $0.calorieTextField.placeholder = "입력"
            $0.calorieTextField.keyboardType = .decimalPad
        }
        
        unitLabel.do {
            $0.font = Constants.Font.textFont
            $0.text = "단위: g(그램)"
        }
        
        addButton.do {
            $0.setTitle("식단 추가", for: .normal)
            $0.titleLabel?.font = Constants.Font.subTitleFont
            $0.setTitleColor(Constants.Color.primaryText, for: .normal)
            $0.layer.borderWidth = Constants.Design.borderWidth
            $0.layer.borderColor = Constants.Color.borderColor
            $0.layer.cornerRadius = Constants.Design.cornerRadius
            $0.backgroundColor = Constants.Color.accentColor
        }
        
        [imageView, cameraButton, foodNameView, nutritionLabel, calorieView, carbView, proteinView, fatView, unitLabel, addButton].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        let spacing = 20
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            $0.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.4)
        }
        
        cameraButton.snp.makeConstraints {
            $0.top.trailing.equalTo(imageView).inset(spacing)
        }
        
        foodNameView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(spacing)
        }
        
        nutritionLabel.snp.makeConstraints {
            $0.top.equalTo(foodNameView.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(spacing)
        }
        
        calorieView.snp.makeConstraints {
            $0.top.equalTo(nutritionLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(spacing)
        }
        
        carbView.snp.makeConstraints {
            $0.top.equalTo(calorieView.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(spacing)
        }

        proteinView.snp.makeConstraints {
            $0.top.equalTo(carbView.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(spacing)
        }

        fatView.snp.makeConstraints {
            $0.top.equalTo(proteinView.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(spacing)
        }
        
        unitLabel.snp.makeConstraints {
            $0.top.equalTo(fatView.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(spacing*2)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(unitLabel).offset(spacing*2)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            $0.height.equalTo(50)
        }
        
    }
}

