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
import YPImagePicker

final class HomeViewController: BaseViewController {
    
    private let repository = DailyRecordRepository.repository
    
    private let homeView = HomeView()
    
    private let foodList: List<Food> = List<Food>()
    
    private let rightBarTitle = UIBarButtonItem()
    
    var tasks: Results<DailyRecord>? {
        didSet {
            reloadLabel()
        }
    }
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        return formatter
    }()
    
    var currentDate = Date().addingTimeInterval(-86400)
    
    private var calorieBurned: Int = 1000
    
    override func loadView() {
        super.loadView()
        
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        checkInitialRun()
        
        repository.printFileLocation()
        
        addCameraButtonTarget()
        
        updateCalorieBurned()
        
        swipeAction()
        
        configureCalendar()
        
        reloadLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateCalorieBurned()
        
        updateAdviceLabel()
        
        reloadLabel()
        
    }
    
    override func configureUI() {
        
        view.backgroundColor = Constants.Color.backgroundColor
        
        rightBarTitle.do {
            $0.title = "기록"
            $0.setTitleTextAttributes([NSAttributedString.Key.font: Constants.Font.subTitleFont as Any], for: .normal)
            $0.tintColor = Constants.Color.primaryText
            $0.style = .plain
            $0.target = self
            $0.action = #selector(recordButtonClicked)
        }
        
        // 오늘의 날짜
        self.navigationItem.title = formatter.string(from: tasks?[0].date ?? Date())
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.Font.subTitleFont as Any]
        self.navigationItem.rightBarButtonItem = rightBarTitle
        
        self.navigationItem.titleView?.tintColor = Constants.Color.primaryText
        self.navigationItem.titleView?.backgroundColor = Constants.Color.backgroundColor
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = Constants.Color.primaryText
        self.navigationItem.backBarButtonItem = backBarButtonItem

    }
    
}

extension HomeViewController {
    private func checkInitialRun() {
        if !userDefaults.bool(forKey: "NotFirst") {
            
            let walkThrough = WalkThroughViewController()
            walkThrough.modalPresentationStyle = .fullScreen
            
            walkThrough.completionHandler = { tasks in
                self.tasks = tasks
            }
            
            self.present(walkThrough, animated: true)
        } else {
            
            currentDate = Date()
            
            let newTasks = repository.fetch(by: currentDate)
            
            // 해당 선택된 날짜에 realm 객체가 아직 생성이 안 된 경우
            if newTasks.count == 0 {
                let record = DailyRecord(date: currentDate, weight: 0.0, caloriesBurned: 0, caloriesConsumed: 0, didWorkout: false, workoutRoutine: nil, workoutTime: nil, food: foodList)
                
                self.repository.addRecord(item: record)
                self.tasks = repository.fetch(by: currentDate)
            } else {
                self.tasks = repository.fetch(by: currentDate)
            }
        }
    }
    
    private func swipeAction() {
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
    
    func addCameraButtonTarget() {
        homeView.workoutView.cameraButton.addTarget(self, action: #selector(YPImagePickerButtonClicked), for: .touchUpInside)
    }
    
    @objc func recordButtonClicked() {
    
        let vc = RecordViewController()
        
        vc.recordView.todayWeightView.cellContent.text = String(tasks?[0].weight ?? 0.0)
        vc.recordView.calorieView.cellContent.text = String(tasks?[0].caloriesConsumed ?? 0)
        
//        vc.completionHandler = { weight, calorie in
//            self.repository.editWeightCalorie(item: self.tasks ?? self.repository.fetch(), weight: weight, calorie: calorie)
//        }
        
        vc.tasks = self.tasks
        vc.currentDate = self.currentDate
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func reloadLabel() {
        
        homeView.weightView.todayWeightView.cellContent.text = String(tasks?[0].weight ?? 0.0)
        homeView.calorieView.calorieConsumed.cellContent.text = String(tasks?[0].caloriesConsumed ?? 0)
        homeView.calorieView.calorieBurned.cellContent.text = String(calorieBurned)

        homeView.calorieView.calorieSurplus.cellContent.text = String(Int(tasks?[0].caloriesConsumed ?? 0) - calorieBurned)
        homeView.workoutView.todayWorkoutTextField.text = String(tasks?[0].workoutRoutine ?? "")
        homeView.workoutView.workoutTimeTextField.text = String(tasks?[0].workoutTime ?? "")
        homeView.workoutView.imageView.image = getSavedImage(imageName: "\(String(describing: self.tasks?[0].objectId)).png")
        
        self.navigationItem.title = formatter.string(from: tasks?[0].date ?? currentDate)
    }
    
    private func updateCalorieBurned() {
        
        HealthKitManager.shared.fetchEnergyBurned(date: self.currentDate) { calorie in
            self.calorieBurned = calorie ?? 1000
        }
    }
    
    @objc func YPImagePickerButtonClicked() {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                
                self.homeView.workoutView.imageView.image = photo.image
                self.saveImageToDocumentDirectory(imageName: "\(String(describing: self.tasks?[0].objectId)).png", image: photo.image)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
        
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        // 1. 이미지를 저장할 경로를 설정해줘야함 - 도큐먼트 폴더,File 관련된건 Filemanager가 관리함(싱글톤 패턴)
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 압축(image.pngData())
        // 압축할거면 jpegData로~(0~1 사이 값)
        guard let data = image.pngData() else {
            print("압축이 실패했습니다.")
            return
        }
        
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기하는 경우
        // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            // 4-2. 이미지가 존재한다면 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다.")
            }
        }
        
        // 5. 이미지를 도큐먼트에 저장
        // do try catch 문으로 에러 처리
        do {
            try data.write(to: imageURL)
            print("이미지 저장완료")
        } catch {
            print("이미지를 저장하지 못했습니다.")
        }
    }
    
    func getSavedImage(imageName: String) -> UIImage? {
      if let dir: URL
        = try? FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false) {
        let path: String
          = URL(fileURLWithPath: dir.absoluteString)
              .appendingPathComponent(imageName).path
        let image: UIImage? = UIImage(contentsOfFile: path)
        
        return image
      }
      return nil
    }
    
    func updateAdviceLabel() {
        let num = Int.random(in: 0...Constants.Text.adviceMessage.count-1)
        self.homeView.adviceView.adviceLabel.text = Constants.Text.adviceMessage[num]
    }
}

extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    private func configureCalendar() {
        homeView.calendar.delegate = self
        homeView.calendar.dataSource = self
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        // textfield에 입력된 값 realm에 저장
        repository.editWorkoutRoutine(item: tasks ?? repository.fetch(), routine: homeView.workoutView.todayWorkoutTextField.text ?? "")
        repository.editWorkoutTime(item: tasks ?? repository.fetch(), time: homeView.workoutView.workoutTimeTextField.text ?? "")
        
        // 선택된 날짜에 realm 객체가 없을 경우
        currentDate = date
        let newTasks = repository.fetch(by: currentDate)
        
        if newTasks.count == 0 {
            let record = DailyRecord(date: currentDate, weight: 0.0, caloriesBurned: 0, caloriesConsumed: 0, didWorkout: false, workoutRoutine: nil, workoutTime: nil, food: foodList)
            
            repository.addRecord(item: record)
            tasks = repository.fetch(by: currentDate)
        } else {
            tasks = repository.fetch(by: currentDate)
        }
        
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
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // 선택해제 막기
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
}


