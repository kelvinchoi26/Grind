//
//  WalkThroughView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/20.
//

import UIKit

final class WalkThroughView: BaseView {
    
    private let textLabel = UILabel()
    private let walkThroughView = UIView()
    
    let weightTextField = UITextField()
    let confirmButton = UIButton()
    

    override func configureUI() {
        super.configureUI()
        
        walkThroughView.do {
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = Constants.Design.borderWidth
            $0.layer.borderColor = Constants.Color.borderColor
        }
        
        textLabel.do {
            $0.numberOfLines = 0
            $0.text = Constants.Text.walkThroughWelcomeText
            $0.textColor = Constants.Color.primaryText
            $0.font = Constants.Font.subTitleFont
        }
        
        weightTextField.do {
            $0.font = Constants.Font.subTitleFont
            $0.textColor = Constants.Color.primaryText
            $0.placeholder = Constants.Text.walkThroughTextField
            $0.layer.borderWidth = Constants.Design.borderWidth
            $0.layer.borderColor = Constants.Color.borderColor
            $0.keyboardType = .decimalPad
        }
        
        confirmButton.do {
            $0.backgroundColor = Constants.Color.buttonColor
            $0.tintColor = Constants.Color.primaryText
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(Constants.Color.primaryText, for: .normal)
            $0.layer.borderWidth = Constants.Design.borderWidth
            $0.layer.cornerRadius = 16
        }
        
        self.addSubview(walkThroughView)
        
        [textLabel, weightTextField, confirmButton].forEach {
            walkThroughView.addSubview($0)
        }
        
        self.layer.borderWidth = Constants.Design.borderWidth
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        walkThroughView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(walkThroughView).inset(20)
            $0.leading.trailing.equalTo(walkThroughView).inset(25)
            $0.bottom.equalTo(weightTextField.snp.top).offset(-20)
        }
        
        weightTextField.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(walkThroughView).inset(25)
            $0.bottom.equalTo(confirmButton.snp.top).offset(-20)
        }
    
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(walkThroughView).multipliedBy(0.2)
            $0.bottom.leading.trailing.equalTo(walkThroughView).inset(20)
        }
    }
}
