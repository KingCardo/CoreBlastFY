//
//  VideoView.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/9/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit
import AVFoundation

class VideoView: UIView {
   
    var looper: Looper?
    var player: QueuePlayerLooper?

    init(frame: CGRect, urls: [URL], loopCount: Int) {
        super.init(frame: frame)
        player = QueuePlayerLooper(videoURLs: urls, loopCount: loopCount)
        looper = player
        playVideo()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func playVideo() {
        looper?.start(in: layer)
    }

    func pauseVideo() {
        looper?.stop()
    }
    
    deinit {
        pauseVideo()
    }
}
