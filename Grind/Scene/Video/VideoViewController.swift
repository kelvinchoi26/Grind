//
//  VideoViewController.swift
//  Grind
//
//  Created by 최형민 on 2023/02/02.
//

import UIKit

final class VideoViewController: BaseViewController {
    
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
        
        self.navigationItem.title = "3대운동 추천 영상"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.Font.subTitleFont as Any]
        
        self.navigationItem.titleView?.tintColor = Constants.Color.primaryText
        self.navigationItem.titleView?.backgroundColor = Constants.Color.backgroundColor
        
        self.view.backgroundColor = Constants.Color.backgroundColor
    }
    
}
