//
//  HomeAdviceView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/19.
//

import UIKit

final class HomeAdviceView: BaseView {
    
    let bubbleImage = UIImageView()
    let adviceLabel = UILabel()
    
    override func configureUI() {
        self.backgroundColor = .clear
        
        bubbleImage.do {
            $0.image = UIImage(named: "bubble")
            $0.contentMode = .scaleAspectFill
        }
        
        adviceLabel.do {
            $0.font = Constants.Font.smallFont
            $0.textColor = Constants.Color.primaryText
            $0.textAlignment = .center
            $0.text = "운동은 주 7일 !!"
        }
        
        [bubbleImage, adviceLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        bubbleImage.snp.makeConstraints {
            $0.top.bottom.equalTo(self).inset(10)
            $0.width.equalTo(self).multipliedBy(0.5)
            $0.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
        }
        
        adviceLabel.snp.makeConstraints {
            $0.edges.equalTo(bubbleImage).inset(10)
        }
    }
}
