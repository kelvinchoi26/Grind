//
//  VideoViewController.swift
//  Grind
//
//  Created by 최형민 on 2023/02/02.
//

import UIKit
import YouTubeiOSPlayerHelper

final class VideoViewController: BaseViewController {
    
    let videoView = VideoView()
    
    override func loadView() {
        super.loadView()
   
        self.view = videoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoView.benchVideoView.load(withVideoId: "3xaSY1ze8k8")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.navigationItem.title = "3대운동 추천 영상"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.Font.subTitleFont as Any]
        
        self.navigationItem.titleView?.tintColor = Constants.Color.primaryText
        self.navigationItem.titleView?.backgroundColor = Constants.Color.backgroundColor
        
        self.view.backgroundColor = Constants.Color.backgroundColor
    }
    
}
