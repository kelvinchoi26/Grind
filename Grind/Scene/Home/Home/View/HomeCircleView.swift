//
//  HomeCircleView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/19.
//

import UIKit

final class HomeCircleView: BaseView {
    
    var cellTitle = UILabel()
    var cellContent = UILabel()
    
    override func configureUI() {
        super.configureUI()
        
        self.layer.borderWidth = Constants.Design.borderWidth
        self.layer.borderColor = Constants.Color.primaryText?.cgColor
        
        cellTitle.do {
            $0.font = Constants.Font.textFont
            $0.textColor = Constants.Color.primaryText
            $0.textAlignment = .center
            $0.numberOfLines = 1
        }
        
        cellContent.do {
            $0.font = Constants.Font.subTitleFont
            $0.textColor = Constants.Color.primaryText
            $0.textAlignment = .center
            $0.numberOfLines = 1
        }
        
        [cellTitle, cellContent].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        let spacing = 10
        
        cellTitle.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(self).inset(spacing)
            $0.width.equalTo(self)
        }
        
        cellContent.snp.makeConstraints {
            $0.top.equalTo(cellTitle).inset(spacing)
            $0.centerX.equalTo(self)
            $0.bottom.equalTo(self).inset(spacing)
            $0.width.equalTo(self)
        }
        
    }
    
    
}
