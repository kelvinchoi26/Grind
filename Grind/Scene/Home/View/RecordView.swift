//
//  RecordView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/23.
//

import UIKit

final class RecordView: BaseView {
    
    let todayWeightView = RecordCircleView()
    let calorieView = RecordCircleView()
    let overallView = UIView()
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = .clear
        
        overallView.do {
            $0.layer.cornerRadius = Constants.Design.cornerRadius
            $0.layer.borderColor = Constants.Color.borderColor
            $0.layer.borderWidth = Constants.Design.borderWidth
        }
        
        todayWeightView.do {
            $0.cellTitle.font = Constants.Font.titleFont
            $0.cellTitle.text = "오늘의 체중"
            $0.cellContent.font = Constants.Font.subTitleFont
        }
        
        calorieView.do {
            $0.cellTitle.font = Constants.Font.titleFont
            $0.cellTitle.text = "섭취 칼로리"
            $0.cellContent.font = Constants.Font.subTitleFont
        }
        
        self.addSubview(overallView)
        
        [todayWeightView, calorieView].forEach {
            overallView.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        overallView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(overallView.snp.width)
        }
        
        todayWeightView.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(overallView).inset(20)
            $0.bottom.equalTo(calorieView.snp.top).offset(-20)
        }
        
        calorieView.snp.makeConstraints {
            $0.height.equalTo(todayWeightView.snp.height)
            $0.bottom.leading.trailing.equalTo(overallView).inset(20)
        }
    }
}
