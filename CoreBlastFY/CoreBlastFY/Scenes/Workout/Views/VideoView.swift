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

    init(frame: CGRect, urls: [URL], loopCount: Int, numberOfSets: Int) {
        super.init(frame: frame)
        looper = PlayerLooper(videoURLs: urls, loopCount: loopCount, numberOfSets: numberOfSets)
       // playVideo()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func playVideo() {
        looper?.start(in: layer)
    }
    
    func advanceToNextItem() {
        looper?.advanceToNextItem()
    }

    func pauseVideo() {
        looper?.stop()
    }
    
    deinit {
        pauseVideo()
    }
}
