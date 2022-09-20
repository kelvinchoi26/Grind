//
//  WalkThroughViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/20.
//

import Foundation

final class WalkThroughViewController: BaseViewController {
    
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
        let weight = walkThrough.weightTextField.text
        
        
        userDefaults.set(true, forKey: "NotFirst")
        self.dismiss(animated: false)
    }
    
    override func configureUI() {
        view.backgroundColor = Constants.Color.backgroundColor
    }
}
