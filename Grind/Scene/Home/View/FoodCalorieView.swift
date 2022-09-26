//
//  FoodCalorieView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/27.
//

import UIKit

final class FoodCalorieView: BaseView {
    
    var calorieLabel = UILabel()
    var calorieTextField = UITextField()
    
    override func configureUI() {
        super.configureUI()
        
        calorieLabel.do {
            $0.font = Constants.Font.textFont
            $0.textColor = Constants.Color.primaryText
        }
        
        calorieTextField.do {
            $0.font = Constants.Font.textFont
            $0.textColor = Constants.Color.primaryText
            $0.textAlignment = .left
        }
    }
    
    override func setConstraints() {
        calorieLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalTo(self).inset(20)
        }
        
        calorieTextField.snp.makeConstraints {
            $0.trailing.top.bottom.equalTo(self).inset(20)
            $0.leading.equalTo(calorieLabel).offset(20)
        }
    }

}
