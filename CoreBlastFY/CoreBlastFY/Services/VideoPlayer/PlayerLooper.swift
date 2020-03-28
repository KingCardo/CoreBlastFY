//
//  PlayerLooper.swift
//  Flexx
//
//  Created by Riccardo Washington on 5/14/18.
//  Copyright © 2018 Riccardo Washington. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerLooper: NSObject, Looper {
    // MARK: Types

    var superViewLayer: CALayer?
    
    private struct ObserverContexts {
        static var isLooping = 0
        
        static var isLoopingKey = "isLooping"
        
        static var loopCount = 0
        
        static var loopCountKey = "loopCount"
        
        static var playerItemDurationKey = "duration"
    }

    // MARK: Properties

    private var player: AVQueuePlayer?

    private var playerLayer: AVPlayerLayer?

    private var playerLooper: AVPlayerLooper?

    private var isObserving = false

    private let numberOfTimesToPlay: Int

    private let videoURL: [URL]
    
    private var playerItems: [AVPlayerItem] = []

    // MARK: Looper

    required init(videoURLs: [URL], loopCount: Int, numberOfSets: Int) {
        self.videoURL = videoURLs
        self.numberOfTimesToPlay = loopCount

        super.init()
        
        self.videoURL.forEach { (url) in
            let playerItem = AVPlayerItem(url: url)
            playerItems.append(playerItem)
            
            playerItem.asset.loadValuesAsynchronously(forKeys: [ObserverContexts.playerItemDurationKey], completionHandler: {()->Void in
    
                  DispatchQueue.main.async(execute: {

                      var durationError: NSError? = nil
                      let durationStatus = playerItem.asset.statusOfValue(forKey: ObserverContexts.playerItemDurationKey, error: &durationError)
                    guard durationStatus == .loaded else {
                        print("Failed to load duration property with error: \(String(describing: durationError))"); return }

                  })
              })
              }
        
        let array = Array(repeating: playerItems, count: numberOfSets).flatMap({$0})
        playerItems = array
    }
    
    deinit {
        stop()
    }

    func advanceToNextItem() {
        stop()
        guard !playerItems.isEmpty else { return }
        playerItems.removeFirst()
        guard let superViewLayer = superViewLayer else { return }
        guard let superViewSuperLayer = superViewLayer.superlayer?.bounds else { return }
        superViewLayer.frame = superViewSuperLayer
        start(in: superViewLayer)
    }
    
    func start(in parentLayer: CALayer) {
        superViewLayer = parentLayer
        player = AVQueuePlayer()
        player?.isMuted = true 
        guard let playerItem = playerItems.first else { stop(); return }
        self.playerLooper = AVPlayerLooper(player: player!, templateItem: playerItem)
        self.startObserving()
        playerLayer = AVPlayerLayer(player: player)

        guard let playerLayer = playerLayer else { return }
        playerLayer.frame = parentLayer.bounds
        parentLayer.addSublayer(playerLayer)
       
        player?.play()
      
    }
    
    func resume() {
        player?.play()
    }
    
    func pauseVideo() {
         player?.pause()
    }

    func stop() {
        player?.pause()
        stopObserving()

        playerLooper?.disableLooping()
        playerLooper = nil

        playerLayer?.removeFromSuperlayer()
        playerLayer = nil

        player = nil
    }

    // MARK: Convenience

    private func startObserving() {
        guard let playerLooper = playerLooper, !isObserving else { return }

        playerLooper.addObserver(self, forKeyPath: ObserverContexts.isLoopingKey, options: .new, context: &ObserverContexts.isLooping)
        playerLooper.addObserver(self, forKeyPath: ObserverContexts.loopCountKey, options: .new, context: &ObserverContexts.loopCount)

        isObserving = true
    }

    private func stopObserving() {
        guard let playerLooper = playerLooper, isObserving else { return }

        playerLooper.removeObserver(self, forKeyPath: ObserverContexts.isLoopingKey, context: &ObserverContexts.isLooping)
        playerLooper.removeObserver(self, forKeyPath: ObserverContexts.loopCountKey, context: &ObserverContexts.loopCount)

        isObserving = false
    }

    // MARK: KVO

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &ObserverContexts.isLooping {
            if let loopingStatus = change?[.newKey] as? Bool, !loopingStatus {
                print("Looping ended due to an error")
            }
        }
        else if context == &ObserverContexts.loopCount {
            guard let playerLooper = playerLooper else { return }

            if numberOfTimesToPlay > 0 && playerLooper.loopCount >= numberOfTimesToPlay - 1 {
                print("Exceeded loop limit of \(numberOfTimesToPlay) and disabling looping");
                stopObserving()
                playerLooper.disableLooping()
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
