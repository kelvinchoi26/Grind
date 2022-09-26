//
//  ImageViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/27.
//

import Foundation
import UIKit
import YPImagePicker

final class FoodViewController: BaseViewController {
    
    let foodView = FoodView()
    
    override func loadView() {
        super.loadView()
        
        self.view = foodView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
}

