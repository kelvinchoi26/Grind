//
//  RecordViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/23.
//

import Foundation

final class RecordViewController: BaseViewController {
    
    let recordView = RecordView()
    
    var completionHandler: ((String, String) -> ())?
    
    override func loadView() {
        super.loadView()
        
        self.view = recordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calorieAddTarget()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        completionHandler?(self.recordView.todayWeightView.cellContent.text ?? "", self.recordView.calorieView.cellContent.text ?? "")
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
        let vc = FoodViewController()
        
        self.present(vc, animated: true, completion: nil)
    }
}
