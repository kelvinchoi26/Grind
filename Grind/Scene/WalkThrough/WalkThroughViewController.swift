//
//  WalkThroughViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/20.
//

import UIKit

final class WalkThroughViewController: BaseViewController {
    
    private let repository = DailyRecordRepository.repository
    
    let walkThrough = WalkThroughView()
    
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
        
        let record = DailyRecord(date: Date(), weight: Double(weight), caloriesBurned: nil, caloriesConsumed: nil, photo: nil, didWorkout: false, workoutRoutine: nil, workoutTime: nil, condition: nil)
        
        repository.addRecord(item: record)
        
        HealthKitManager.shared.checkAuthorization()
        HealthKitManager.shared.fetchEnergyBurned()
        
        userDefaults.set(true, forKey: "NotFirst")
        self.dismiss(animated: false)
    }
    
    override func configureUI() {
        view.backgroundColor = Constants.Color.backgroundColor
    }
}

extension WalkThroughViewController {
    func alertEmptyTextField() {
        let alert = UIAlertController(title: "", message: "체중을 입력해주세요!", preferredStyle: .alert)
        
        let done = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(done)
        
        self.present(alert, animated: true)
    }
}
