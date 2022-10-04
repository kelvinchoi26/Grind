//
//  HomeWeightView.swift
//  Grind
//
//  Created by 최형민 on 2022/09/19.
//

import UIKit

final class HomeWeightView: BaseView {
    
    let todayWeightView = HomeCircleView()
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = .clear
        
        [todayWeightView].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        todayWeightView.snp.makeConstraints {
            $0.top.bottom.equalTo(self).inset(10)
            $0.width.equalTo(self).multipliedBy(0.25)
            $0.centerX.equalTo(self)
        }
        
    }
}
