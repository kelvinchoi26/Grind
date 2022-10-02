//
//  TabViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/30.
//

import UIKit
import Tabman
import Pageboy

final class TabViewController: TabmanViewController {
    
    // 페이징 할 뷰 컨트롤러
    var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        appendVC()
        
        // 탭바 생성
        let bar = TMBar.ButtonBar()
        addBar(bar, dataSource: self, at: .top)
        configureTabBar(bar: bar)
    }
}

extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        switch index {
        case 0:
            return TMBarItem(title: "체중/칼로리 입력")
        case 1:
            return TMBarItem(title: "오늘의 식단")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
}

extension TabViewController {
    func appendVC() {
        
        let recordVC = RecordViewController()
        let foodVC = FoodViewController()
        
        [recordVC, foodVC].forEach {
            viewControllers.append($0)
        }

    }
    
    func configureTabBar(bar: TMBar.ButtonBar) {
        bar.layout.transitionStyle = .snap
        // 왼쪽 여백주기
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 13.0, bottom: 0.0, right: 20.0)
        
        // 간격
        bar.layout.interButtonSpacing = 35
        
        bar.backgroundView.style = .blur(style: .light)
        
        bar.buttons.customize { (button) in
            button.tintColor = Constants.Color.primaryText
//            button.selectedTintColor = Constants.Color.primaryText
            button.font = Constants.Font.subTitleFont ?? .boldSystemFont(ofSize: 20)
//            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        
        bar.indicator.weight = .heavy
        bar.indicator.tintColor = Constants.Color.accentColor
    }
}
