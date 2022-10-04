//
//  SettingTableViewCell.swift
//  Grind
//
//  Created by 최형민 on 2022/10/04.
//

import UIKit
import Then

final class SettingTableViewCell: BaseTableViewCell {
    
    let titleLabel = UILabel()
    
    override func configureUI() {
        
        titleLabel.do {
            $0.textColor = Constants.Color.primaryText
            $0.font = Constants.Font.subTitleFont
        }
        
        contentView.addSubview(titleLabel)
    }
    
    override func setConstraints() {
        let spacing = 10
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalTo(self).inset(spacing)
        }
    }
}
