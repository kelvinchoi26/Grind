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
            $0.font = Constants.Font.subTitleFont
            $0.textColor = Constants.Color.primaryText
            $0.textAlignment = .left    
        }
        
        calorieTextField.do {
            $0.font = Constants.Font.subTitleFont
            $0.textColor = Constants.Color.primaryText
            $0.textAlignment = .left
        }
        
        [calorieLabel, calorieTextField].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        calorieLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(self).inset(10)
            $0.leading.equalTo(self).inset(20)
            $0.width.equalTo(100)
        }
        
        calorieTextField.snp.makeConstraints {
            $0.top.bottom.equalTo(self).inset(10)
            $0.trailing.equalTo(self).inset(20)
            $0.leading.equalTo(calorieLabel.snp.trailing).offset(20)
        }
    }

}
