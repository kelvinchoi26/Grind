//
//  ImageViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/27.
//

import Foundation
import UIKit
import YPImagePicker
import RealmSwift
import Toast

final class FoodViewController: BaseViewController {
    
    private let repository = DailyRecordRepository.repository
    
    let foodView = FoodView()
    
    var tasks: Results<DailyRecord>?
    
    var currentDate = Date().addingTimeInterval(-86400)
    
    override func loadView() {
        super.loadView()
        
        self.view = foodView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCameraButtonTarget()
        
        addFoodButtonTarget()
            
    }
    
}

extension FoodViewController {
    func addCameraButtonTarget() {
        foodView.cameraButton.addTarget(self, action: #selector(YPImagePickerButtonClicked), for: .touchUpInside)
    }
    
    func addFoodButtonTarget() {
        foodView.addButton.addTarget(self, action: #selector(addFoodButtonClicked), for: .touchUpInside)
    }
    
    @objc func addFoodButtonClicked() {
        
        guard let foodName = foodView.foodNameView.calorieTextField.text, !foodName.isEmpty else {
            alertEmptyTextField()
            return
        }
        
        guard let calorie = foodView.calorieView.calorieTextField.text, !calorie.isEmpty else {
            alertEmptyTextField()
            return
        }
        
        guard let carb = foodView.carbView.calorieTextField.text, !carb.isEmpty else {
            alertEmptyTextField()
            return
        }
        
        guard let protein = foodView.proteinView.calorieTextField.text, !protein.isEmpty else {
            alertEmptyTextField()
            return
        }
        
        guard let fat = foodView.fatView.calorieTextField.text, !fat.isEmpty else {
            alertEmptyTextField()
            return
        }
        
        guard let image = foodView.imageView.image ?? UIImage(systemName: "photo.on.rectangle") else { return }
        
        let food = Food(calorie: Int(calorie) ?? 0, carb: Int(carb) ?? 0, protein: Int(protein) ?? 0, fat: Int(fat) ?? 0, name: foodName, uploadedDate: tasks?[0].date ?? Date())
        
        repository.addFood(item: tasks?[0] ?? repository.fetch()[0], food: food, addedCalorie: food.calorie)
        
        saveImageToDocumentDirectory(imageName: "\(food.objectId).png", image: image)
        
        self.dismiss(animated: true)
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
                
                self.foodView.imageView.image = photo.image
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
    
    func alertEmptyTextField() {
        self.view.makeToast("모든 영양정보를 입력해주세요!", duration: 1)
    }
    
}


