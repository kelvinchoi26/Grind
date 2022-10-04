//
//  SettingTableViewCell.swift
//  Grind
//
//  Created by 최형민 on 2022/10/04.
//

import UIKit
import Then

final class SettingTableViewCell: BaseTableViewCell {
    
    let titleImage = UIImageView()
    let titleLabel = UILabel()
    let versionLabel = UILabel()
    
    override func configureUI() {
        
        titleImage.do {
            $0.tintColor = Constants.Color.primaryText
        }
        
        titleLabel.do {
            $0.textColor = Constants.Color.primaryText
            $0.font = Constants.Font.subTitleFont
        }
        
        versionLabel.do {
            $0.textColor = Constants.Color.primaryText
            $0.font = Constants.Font.subTitleFont
        }
        
        [titleImage, titleLabel, versionLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        let spacing = 10
        
        titleImage.snp.makeConstraints {
            $0.top.bottom.leading.equalTo(self).inset(spacing)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(self).inset(spacing)
            $0.leading.equalTo(titleImage.snp.trailing).offset(20)
        }
        
        versionLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalTo(self).inset(spacing)
        }
    }
}
