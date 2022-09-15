//
//  HomeCollectionViewCell.swift
//  Grind
//
//  Created by 최형민 on 2022/09/15.
//

import UIKit
import SnapKit
import Then

final class HomeCollectionViewCell: BaseCollectionViewCell {
    
    private lazy var containerStackView = UIStackView(
        arrangedSubviews: [cellTitle, cellContent]
    )
    
    private let cellTitle = UILabel()
    private let cellContent = UILabel()
    
    override func configureUI() {
        self.backgroundColor = Constants.Color.accentColor
        self.layer.cornerRadius = Constants.Design.cornerRadius
        self.layer.borderWidth = Constants.Design.borderWidth
        
        containerStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
        }
        
        cellTitle.do {
            $0.textColor = Constants.Color.cellText
            $0.font = Constants.Font.textFont
        }
        
        cellContent.do {
            $0.textColor = Constants.Color.cellText
            $0.font = Constants.Font.textFont
        }
    }
    
    override func setConstraints() {
        addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
    }
}
