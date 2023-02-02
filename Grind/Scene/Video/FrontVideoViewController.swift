//
//  FrontVideoViewController.swift
//  Grind
//
//  Created by 최형민 on 2023/02/02.
//

import Foundation

final class FrontVideoViewController: BaseViewController {
    
    let videoView = VideoView()
    
    override func loadView() {
        super.loadView()
        
        self.view = videoView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadYTVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadYTVideo() {
        videoView.videoView.load(withVideoId: "qF53tsAr6Uw")
    }
}
