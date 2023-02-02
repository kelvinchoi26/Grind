//
//  VideoViewController.swift
//  Grind
//
//  Created by 최형민 on 2023/02/02.
//

import UIKit
import YouTubeiOSPlayerHelper
import Tabman
import Pageboy

final class VideoViewController: TabmanViewController {
    
    private var viewControllers = [FrontVideoViewController(), BackVideoViewController(), LegVideoViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.interButtonSpacing = 10
        
        bar.buttons.customize { (button) in
            button.tintColor = Constants.Color.primaryText
            button.selectedTintColor = Constants.Color.primaryText
            button.selectedFont = Constants.Font.subTitleFont
        }
        
        addBar(bar, dataSource: self, at: .top)
        
        configureUI()
    }
    
    func configureUI() {
        
        self.navigationItem.title = "운동 추천 영상"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.Font.subTitleFont as Any]
        
        self.navigationItem.titleView?.tintColor = Constants.Color.primaryText
        self.navigationItem.titleView?.backgroundColor = Constants.Color.backgroundColor
        
        self.view.backgroundColor = Constants.Color.backgroundColor
    }
    
}

extension VideoViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        var title = ""
        
        switch index {
        case 0:
            title = "전면 운동 영상"
        case 1:
            title = "후면 운동 영상"
        case 2:
            title = "하체 운동 영상"
        default:
            break
        }
        
        return TMBarItem(title: title)
    }
    
    
}
