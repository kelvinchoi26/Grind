//
//  BackVideoViewController.swift
//  Grind
//
//  Created by 최형민 on 2023/02/02.
//

import Foundation

final class BackVideoViewController: BaseViewController {
    
    let videoView = VideoView()
    
    override func loadView() {
        super.loadView()
        
        self.view = videoView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoView.videoLabel.text = "후면 운동"
        
        loadYTVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadYTVideo() {
        videoView.videoView.load(withVideoId: "xEmpSLk4TdA")
    }
}
