//
//  VideoView.swift
//  Grind
//
//  Created by 최형민 on 2023/02/02.
//

import UIKit
import YouTubeiOSPlayerHelper

final class VideoView: BaseView {
    let benchVideoView = YTPlayerView()
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = .clear
        
        self.addSubview(benchVideoView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        benchVideoView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.3)
        }
    }
}
