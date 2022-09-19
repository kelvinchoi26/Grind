//
//  HomeCalorieView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/19.
//

import UIKit

final class HomeCalorieView: BaseView {
    
    let calorieConsumed = HomeCircleView()
    let calorieSurplus = HomeCircleView()
    let calorieBurned = HomeCircleView()
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = .clear
        
        [calorieConsumed, calorieSurplus, calorieBurned].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        calorieSurplus.snp.makeConstraints {
            $0.top.bottom.equalTo(self).inset(10)
            $0.width.equalTo(self).multipliedBy(0.25)
            $0.centerX.equalTo(self)
        }
        
        calorieConsumed.snp.makeConstraints {
            $0.top.bottom.equalTo(self).inset(10)
            $0.width.equalTo(self).multipliedBy(0.25)
            $0.trailing.equalTo(calorieSurplus.snp.leading).offset(-30)
        }
        
        calorieBurned.snp.makeConstraints {
            $0.top.bottom.equalTo(self).inset(10)
            $0.width.equalTo(self).multipliedBy(0.25)
            $0.leading.equalTo(calorieSurplus.snp.trailing).offset(30)
        }
    }
}
