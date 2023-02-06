//
//  LegVideoViewController.swift
//  Grind
//
//  Created by 최형민 on 2023/02/02.
//

import Foundation

final class LegVideoViewController: BaseViewController {
    
    let videoView = VideoView()
    
    override func loadView() {
        super.loadView()
        
        self.view = videoView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoView.videoLabel.text = "하체 운동"
        
        loadYTVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadYTVideo() {
        DispatchQueue.main.async { [weak self] in
            self?.videoView.videoView.load(withVideoId: "3xaSY1ze8k8")
        }
    }
}
