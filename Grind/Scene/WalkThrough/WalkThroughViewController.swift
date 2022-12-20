//
//  WalkThroughViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/20.
//

import UIKit
import RealmSwift

final class WalkThroughViewController: BaseViewController {
    
    var tasks: Results<DailyRecord>?
    
    private let repository = DailyRecordRepository.repository
    
    var completionHandler: ((Results<DailyRecord>?) -> ())?
    
    let walkThrough = WalkThroughView()
    
    var currentDate = Date().addingTimeInterval(-86400)
    
    private let foodList: List<Food> = List<Food>()
    
    override func loadView() {
        super.loadView()
        
        self.view = walkThrough
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        walkThrough.confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
    }
    
    @objc func confirmButtonClicked() {
        
        guard let weight = walkThrough.weightTextField.text, !weight.isEmpty else {
            alertEmptyTextField()
            return
        }
        
        let doubleWeight = Double(weight) ?? 0.0
        
        // 소수점 아래 한 자리까지 반올림
        let finalWeight = String(format: "%.1f", doubleWeight)
        
        currentDate = Date()
        let record = DailyRecord(date: currentDate, weight: Double(finalWeight), caloriesBurned: 0, caloriesConsumed: 0, didWorkout: false, workoutRoutine: nil, workoutTime: nil, food: foodList)
        
        repository.addRecord(item: record)
        
        tasks = repository.fetch(by: currentDate)
        
        print(tasks)
        
        completionHandler?(tasks)
        
        HealthKitManager.shared.checkAuthorization()
        
        userDefaults.set(true, forKey: "NotFirst")
        self.dismiss(animated: false)
    }
    
    override func configureUI() {
        view.backgroundColor = Constants.Color.backgroundColor
    }
}

extension WalkThroughViewController {
    func alertEmptyTextField() {
        let alert = UIAlertController(title: "", message: "체중을 입력해주세요", preferredStyle: .alert)
        
        let done = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(done)
        
        self.present(alert, animated: true)
    }
}
