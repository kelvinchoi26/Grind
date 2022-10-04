//
//  BaseTableViewCell.swift
//  Grind
//
//  Created by 최형민 on 2022/10/04.
//

import UIKit
import Then

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .clear
        self.tintColor = Constants.Color.primaryText
        self.layer.cornerRadius = Constants.Design.cornerRadius
        self.layer.borderWidth = Constants.Design.borderWidth
    }
    
    func setConstraints() {}

}
