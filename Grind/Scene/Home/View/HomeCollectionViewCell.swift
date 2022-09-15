//
//  HomeCollectionViewCell.swift
//  Grind
//
//  Created by 최형민 on 2022/09/15.
//

import UIKit
import Then

final class HomeCollectionViewCell: BaseCollectionViewCell {
    
    let cellTitle = UILabel()
    let cellContent = UILabel()
    
    override func configureUI() {
        self.layer.cornerRadius = 20
        
        cellTitle.do {
            $0.textColor = Constants.BaseColor.cellText
            $0.font = .
            
        }
    }
    
    override func setConstraints() {
        <#code#>
    }
}
