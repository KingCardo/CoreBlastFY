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
   
    private var looper: Looper?

    init(frame: CGRect, urls: [URL], loopCount: Int, numberOfSets: Int) {
        
        looper = PlayerLooper(videoURLs: urls, loopCount: loopCount, numberOfSets: numberOfSets)
        super.init(frame: frame)
        clipsToBounds = true
        contentMode = .scaleAspectFit
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func playVideo() {
        looper?.start(in: layer)
    }
    
    func resume() {
        looper?.resume()
    }
    
    func advanceToNextItem() {
        looper?.advanceToNextItem()
    }
    
    func pauseVideo() {
        looper?.pauseVideo()
    }

    func stopVideo() {
        looper?.stop()
    }
    
    deinit {
        stopVideo()
    }
}
