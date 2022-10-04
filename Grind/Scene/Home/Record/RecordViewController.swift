//
//  RecordViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/23.
//

import Foundation
import RealmSwift

final class RecordViewController: BaseViewController {
    
    private let repository = DailyRecordRepository.repository
    
    let recordView = RecordView()
    
    var completionHandler: ((String, String) -> ())?
    
    var tasks: Results<DailyRecord>? {
        didSet {
            reloadLabel()
        }
    }
    
    var currentDate = Date().addingTimeInterval(-86400)
    
    override func loadView() {
        super.loadView()
        
        self.view = recordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calorieAddTarget()
        
        reloadLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let weight = Double(self.recordView.todayWeightView.cellContent.text ?? "") ?? 0.0
        let calorie = self.recordView.calorieView.cellContent.text ?? ""
        
        // 소수점 아래 한 자리까지 반올림
        completionHandler?(String(format: "%.1f", weight), calorie)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        reloadLabel()
    }
    
    override func configureUI() {
        view.backgroundColor = Constants.Color.backgroundColor
        
    }
}

extension RecordViewController {
    func calorieAddTarget() {
        recordView.calorieButton.addTarget(self, action: #selector(addCalorie), for: .touchUpInside)
    }
    
    @objc func addCalorie() {
        let vc = AddFoodViewController()
        
        vc.tasks = self.tasks
        vc.currentDate = self.currentDate
        
        vc.completionHandler = { tasks in
            self.tasks = tasks
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func reloadLabel() {
        
        recordView.todayWeightView.cellContent.text = String(tasks?[0].weight ?? 0.0)
        recordView.calorieView.cellContent.text = String(tasks?[0].caloriesConsumed ?? 0)
    }
}

