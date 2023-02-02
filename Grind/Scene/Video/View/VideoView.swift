//
//  VideoView.swift
//  Grind
//
//  Created by 최형민 on 2023/02/02.
//

import UIKit
import YouTubeiOSPlayerHelper

final class VideoView: BaseView {
    let videoView = YTPlayerView()
    
    let videoLabel = UILabel()
    
    override func configureUI() {
        
        self.backgroundColor = .clear
        
        videoLabel.do {
            $0.text = "전면 운동"
            $0.font = Constants.Font.textFont
            $0.textColor = Constants.Color.primaryText
        }
        
        [videoView, videoLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        let spacing = 20
        
        videoView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            $0.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.3)
        }
        
        videoLabel.snp.makeConstraints {
            $0.top.equalTo(videoView.snp.bottom).offset(spacing)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
}
