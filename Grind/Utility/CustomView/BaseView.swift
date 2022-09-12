//
//  BaseView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/13.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI() {}
    
    func setConstraints() {}
}
