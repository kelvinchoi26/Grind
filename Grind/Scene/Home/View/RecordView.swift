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
    let calorieButton = UIButton()
    
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
            $0.layer.cornerRadius = Constants.Design.cornerRadius
        }
        
        calorieView.do {
            $0.cellTitle.font = Constants.Font.titleFont
            $0.cellTitle.text = "섭취 칼로리"
            $0.cellContent.font = Constants.Font.subTitleFont
            $0.layer.cornerRadius = Constants.Design.cornerRadius
        }
        
        calorieButton.do {
            $0.setTitle("식단 영양정보 입력", for: .normal)
            $0.titleLabel?.font = Constants.Font.subTitleFont
            $0.setTitleColor(Constants.Color.primaryText, for: .normal)
            $0.layer.borderWidth = Constants.Design.borderWidth
            $0.layer.borderColor = Constants.Color.borderColor
            $0.layer.cornerRadius = Constants.Design.cornerRadius
        }
        
        self.addSubview(overallView)
        
        [todayWeightView, calorieView, calorieButton].forEach {
            overallView.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        let spacing = 20
        
        overallView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        todayWeightView.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(overallView).inset(spacing)
            $0.height.equalTo(overallView.snp.height).multipliedBy(0.35)
        }
        
        calorieView.snp.makeConstraints {
            $0.top.equalTo(todayWeightView.snp.bottom).offset(spacing)
            $0.trailing.leading.equalTo(overallView).inset(spacing)
            $0.height.equalTo(overallView.snp.height).multipliedBy(0.35)
        }
        
        calorieButton.snp.makeConstraints {
            $0.top.equalTo(calorieView.snp.bottom).offset(spacing)
            $0.bottom.leading.trailing.equalTo(overallView).inset(spacing)
        }
    }
}
