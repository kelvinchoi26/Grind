//
//  HomeViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/14.
//

import UIKit
import SnapKit
import Then

final class HomeViewController: BaseViewController {
    
    let homeView = HomeView()
    
    let leftBarTitle = UILabel()
    let rightBarTitle = UILabel()
    
    override func loadView() {
        super.loadView()
        
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func configureUI() {
        view.backgroundColor = Constants.Color.backgroundColor
    }
    
    override func configureNavigationController() {
        super.configureNavigationController()
        
//        let recordBarButton = UIBarButtonItem(title: "기록", style: .plain, target: self, action: nil)
//        let cameraBarButton = UIBarButtonItem(title: "카메라", style: .plain, target: self, action: nil)
        
        leftBarTitle.do {
            $0.textColor = Constants.Color.primaryText
            $0.text = "기록"
            $0.font = Constants.Font.textFont
        }
        
        rightBarTitle.do {
            $0.textColor = Constants.Color.primaryText
            $0.text = "카메라"
            $0.font = Constants.Font.textFont
        }
        
        // 오늘의 날짜
        self.navigationItem.title = "8월 13일"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.Font.subTitleFont as Any]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarTitle)
//        self.navigationItem.leftBarButtonItem = recordBarButton
//        self.navigationItem.rightBarButtonItem = cameraBarButton
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarTitle)
        self.navigationItem.titleView?.tintColor = Constants.Color.primaryText
        self.navigationItem.titleView?.backgroundColor = Constants.Color.backgroundColor
        
    }
}

