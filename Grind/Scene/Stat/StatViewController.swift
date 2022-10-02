//
//  StatViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/14.
//

import Charts
import Then
import RealmSwift
import Foundation
import Algorithms
import UIKit

final class StatViewController: BaseViewController {
    
    private let repository = DailyRecordRepository.repository
    
    private let statView = StatView()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMdd"
        return formatter
    }()
    
    override func loadView() {
        super.loadView()
        
        self.view = statView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queryWeightData()
        queryCalorieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        queryWeightData()
        queryCalorieData()
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.navigationItem.title = "체중/섭취칼로리 통계"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.Font.subTitleFont as Any]
        
        self.navigationItem.titleView?.tintColor = Constants.Color.primaryText
        self.navigationItem.titleView?.backgroundColor = Constants.Color.backgroundColor
        
        self.view.backgroundColor = Constants.Color.backgroundColor
    }
    
}

extension StatViewController: ChartViewDelegate {
    
    func queryWeightData() {
        let tempTasks = repository.fetch()
        var lineDataEntries = [ChartDataEntry]()
        
        for task in tempTasks {
            print(task.date)
            let date = Double(formatter.string(from: task.date)) ?? 0.0
            let weight = task.weight ?? 0.0
            // 체중 입력 안 한 경우 그래프에 포함 안 시킴
            if weight != 0.0 {
                let lineDataEntry = ChartDataEntry(x: date, y: weight)
                lineDataEntries.append(lineDataEntry)
            }
            
        }
        
        let lineChartDataSet = LineChartDataSet(entries: lineDataEntries, label: "체중")
        
        lineChartDataSet.do {
            $0.mode = .cubicBezier
            $0.drawCirclesEnabled = false
            $0.lineWidth = 3
            $0.setColor(Constants.Color.primaryText ?? .black)

            $0.drawFilledEnabled = true
            
            $0.drawHorizontalHighlightIndicatorEnabled = false
            $0.highlightColor = Constants.Color.primaryText ?? .black
            
        }
        
        let data = LineChartData(dataSet: lineChartDataSet)
        
        statView.weightChartView.data = data
    }
    
    func queryCalorieData() {
        let tempTasks = repository.fetch()
        var lineDataEntries = [ChartDataEntry]()
        
        for task in tempTasks {
            print(task.date)
            let date = Double(formatter.string(from: task.date)) ?? 0.0
            let calorie = Double(task.caloriesConsumed)
            // 체중 입력 안 한 경우 그래프에 포함 안 시킴
            if calorie != 0 {
                let lineDataEntry = ChartDataEntry(x: date, y: calorie)
                lineDataEntries.append(lineDataEntry)
            }
            
        }
        
        let lineChartDataSet = LineChartDataSet(entries: lineDataEntries, label: "섭취칼로리")
        
        lineChartDataSet.do {
            $0.mode = .cubicBezier
            $0.drawCirclesEnabled = false
            $0.lineWidth = 3
            $0.setColor(Constants.Color.primaryText ?? .black)

            $0.drawFilledEnabled = true
            
            $0.drawHorizontalHighlightIndicatorEnabled = false
            $0.highlightColor = Constants.Color.primaryText ?? .black
            
        }
        
        let data = LineChartData(dataSet: lineChartDataSet)
        
        statView.calorieChartView.data = data
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        // 유저가 데이터 선택하면서 정보를 확인할 수 있음
        print(entry)
    }
}
