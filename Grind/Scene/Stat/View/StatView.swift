//
//  StatView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/30.
//

import Charts

final class StatView: BaseView {
    let weightChartView = LineChartView()
    let calorieChartView = LineChartView()
    
    override func configureUI() {
        weightChartView.do {
            $0.backgroundColor = Constants.Color.backgroundColor
            $0.rightAxis.enabled = false
            $0.leftAxis.labelFont = Constants.Font.textFont ?? .boldSystemFont(ofSize: 12)
            $0.leftAxis.setLabelCount(6, force: false)
            $0.leftAxis.labelTextColor = Constants.Color.primaryText ?? .black
            $0.leftAxis.axisLineColor = Constants.Color.primaryText ?? .black
            $0.xAxis.labelPosition = .bottom
            $0.xAxis.labelFont = Constants.Font.textFont ?? .boldSystemFont(ofSize: 12)
            
            $0.noDataText = "체중을 입력해주세요."
            $0.noDataFont = Constants.Font.subTitleFont ?? .boldSystemFont(ofSize: 12)
            $0.noDataTextColor = Constants.Color.primaryText ?? .black
            
            $0.leftAxis.drawAxisLineEnabled = false
            $0.leftAxis.drawGridLinesEnabled = false
            $0.rightAxis.drawAxisLineEnabled = false
            $0.rightAxis.drawGridLinesEnabled = false
            $0.xAxis.enabled = false
            $0.leftAxis.enabled = false
            $0.rightAxis.enabled = false
            
            $0.legend.font = Constants.Font.textFont ?? .boldSystemFont(ofSize: 12)
            
        }
        
        calorieChartView.do {
            $0.backgroundColor = Constants.Color.backgroundColor
            $0.rightAxis.enabled = false
            $0.leftAxis.labelFont = Constants.Font.textFont ?? .boldSystemFont(ofSize: 12)
            $0.leftAxis.setLabelCount(6, force: false)
            $0.leftAxis.labelTextColor = Constants.Color.primaryText ?? .black
            $0.leftAxis.axisLineColor = Constants.Color.primaryText ?? .black
            $0.xAxis.labelPosition = .bottom
            $0.xAxis.labelFont = Constants.Font.textFont ?? .boldSystemFont(ofSize: 12)
            
            $0.noDataText = "섭취칼로리를 입력해주세요."
            $0.noDataFont = Constants.Font.subTitleFont ?? .boldSystemFont(ofSize: 12)
            $0.noDataTextColor = Constants.Color.primaryText ?? .black
            
            $0.leftAxis.drawAxisLineEnabled = false
            $0.leftAxis.drawGridLinesEnabled = false
            $0.rightAxis.drawAxisLineEnabled = false
            $0.rightAxis.drawGridLinesEnabled = false
            $0.xAxis.enabled = false
            $0.leftAxis.enabled = false
            $0.rightAxis.enabled = false

            $0.legend.font = Constants.Font.textFont ?? .boldSystemFont(ofSize: 12)
        }
        
        [weightChartView, calorieChartView].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        
        let spacing = 20
        
        weightChartView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.centerX.equalTo(self)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.35)
        }
        
        calorieChartView.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.35)
            $0.top.equalTo(weightChartView.snp.bottom).offset(spacing)
        }
    }
}
