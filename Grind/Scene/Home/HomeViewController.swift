//
//  HomeViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/14.
//

import UIKit
import SnapKit
import Then
import FSCalendar
import Foundation
import RealmSwift

final class HomeViewController: BaseViewController {
    
    private let repository = DailyRecordRepository.repository
    
    private let homeView = HomeView()
    
    private let leftBarTitle = UILabel()
    private let rightBarTitle = UILabel()
    
    var tasks: Results<DailyRecord>? {
        didSet {
            reloadLabel()
        }
    }
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYMMdd"
        return formatter
    }()
    
    var currentDate = Date().addingTimeInterval(-86400)
    
    override func loadView() {
        super.loadView()
        
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        checkInitialRun()
        
        HealthKitManager.shared.checkAuthorization()
        
        repository.printFileLocation()
        
        swipeAction()
        
        configureCalendar()
        
        reloadLabel()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.tasks = self.repository.fetch(by: self.currentDate)
//    }
    
    override func configureUI() {
        
        view.backgroundColor = Constants.Color.backgroundColor

    }
    
    override func setConstraints() {
        
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
        self.navigationItem.title = formatter.string(from: tasks?[0].date ?? Date())
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.Font.subTitleFont as Any]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarTitle)
//        self.navigationItem.leftBarButtonItem = recordBarButton
//        self.navigationItem.rightBarButtonItem = cameraBarButton
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarTitle)
        self.navigationItem.titleView?.tintColor = Constants.Color.primaryText
        self.navigationItem.titleView?.backgroundColor = Constants.Color.backgroundColor
        
    }
}

extension HomeViewController {
    func checkInitialRun() {
        if !userDefaults.bool(forKey: "NotFirst") {
            
            let walkThrough = WalkThroughViewController()
            walkThrough.modalPresentationStyle = .overFullScreen
            
            self.present(walkThrough, animated: true)
        }
    }
    
    func swipeAction() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {

        if swipe.direction == .down {
            homeView.calendar.scope = .month
        }
        else if swipe.direction == .up {
            homeView.calendar.scope = .week
        }
        
    }
    
    func reloadLabel() {
        homeView.weightView.todayWeightView.cellContent.text = String(tasks?[0].weight ?? 0.0)
        homeView.weightView.WeightDiffView.cellContent.text = String(0.0)
        homeView.calorieView.calorieConsumed.cellContent.text = String(tasks?[0].caloriesConsumed ?? 0)
        homeView.calorieView.calorieBurned.cellContent.text = String(tasks?[0].caloriesBurned ?? 0)
        homeView.calorieView.calorieSurplus.cellContent.text = String(0)
        
        self.navigationItem.title = formatter.string(from: tasks?[0].date ?? Date())
    }
}

extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func configureCalendar() {
        homeView.calendar.delegate = self
        homeView.calendar.dataSource = self
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        currentDate = date
        var newTasks = repository.fetch(by: currentDate)
        
        if newTasks.count == 0 {
            let record = DailyRecord(date: currentDate, weight: 0.0, caloriesBurned: nil, caloriesConsumed: nil, photo: nil, didWorkout: false, workoutRoutine: nil, workoutTime: nil, condition: nil)
            
            repository.addRecord(item: record)
            tasks = repository.fetch(by: currentDate)
        } else {
            tasks = repository.fetch(by: currentDate)
        }
        
//        var newTasks: Results<DailyRecord>?
//        newTasks = repository.fetch(by: currentDate)
//        print(newTasks ?? 0)
        
//        if newTasks?[0] != nil {
//            tasks = repository.fetch(by: currentDate)
//        } else {
//            let record = DailyRecord(date: currentDate, weight: 0.0, caloriesBurned: nil, caloriesConsumed: nil, photo: nil, didWorkout: false, workoutRoutine: nil, workoutTime: nil, condition: nil)
//
//            repository.addRecord(item: record)
//            tasks = repository.fetch(by: currentDate)
//        }
        
        calendar.do {
            $0.isHidden = true
            $0.scope = .week
        }
        
        // 일주일 단위일 때는 높이를 맞게 설정
        calendar.snp.remakeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        if calendar.scope == .week {
            calendar.do {
                $0.isHidden = true
            }
            // 일주일 단위일 때는 높이를 맞게 설정
            calendar.snp.remakeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
                $0.trailing.leading.equalToSuperview()
                $0.height.equalTo(0)
            }
        }
        else if calendar.scope == .month {
            calendar.do {
                $0.isHidden = false
            }
            // 한달 단위일 때는 높이를 전체화면으로 설정
            calendar.snp.remakeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
                $0.trailing.leading.equalToSuperview()
                $0.height.equalToSuperview().multipliedBy(0.3)
            }
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    // 선택해제 막기
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
}


