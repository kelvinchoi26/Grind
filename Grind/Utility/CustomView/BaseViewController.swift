//
//  BaseViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/13.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class BaseViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationController()
    }

    func configureNavigationController() { }
    
    func configureUI() {}
    
    func setConstraints() { }
    
}
