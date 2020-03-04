//
//  QueuePlayerLooper.swift
//  Flexx
//
//  Created by Riccardo Washington on 5/14/18.
//  Copyright © 2018 Riccardo Washington. All rights reserved.
//

import Foundation
import AVFoundation

class QueuePlayerLooper : NSObject, Looper {
    
    var inProgress: Bool? = false
    
    // MARK: Types
    
    private struct ObserverContexts {
        static var playerStatus = 0
        
        static var playerStatusKey = "status"
        
        static var currentItem = 0
        
        static var currentItemKey = "currentItem"
        
        static var currentItemStatus = 0
        
        static var currentItemStatusKey = "currentItem.status"
        
        static var urlAssetDurationKey = "duration"
        
        static var urlAssetPlayableKey = "playable"
    }
    
    // MARK: Properties
    
    var player: AVQueuePlayer?
    
    private var playerLayer: AVPlayerLayer?
    
    private var isObserving = false
    
    private var numberOfTimesPlayed = 0
    
    private let numberOfTimesToPlay: Int
    
    private let videoURLs: [URL]
    
    // MARK: Looper
    
    required init(videoURLs: [URL], loopCount: Int) {
        self.videoURLs = videoURLs
        self.numberOfTimesToPlay = loopCount
        
        super.init()
        
        self.videoURLs.forEach { (url) in
        let videoAsset = AVURLAsset(url: url)
        videoAsset.loadValuesAsynchronously(forKeys: [ObserverContexts.urlAssetDurationKey, ObserverContexts.urlAssetPlayableKey]) {
                   /*
                    The asset invokes its completion handler on an arbitrary queue
                    when loading is complete. Because we want to access our AVQueuePlayer
                    in our ensuing set-up, we must dispatch our handler to the main
                    queue.
                    */
                   DispatchQueue.main.async(execute: {
                       var durationError: NSError?
                       let durationStatus = videoAsset.statusOfValue(forKey: ObserverContexts.urlAssetDurationKey, error: &durationError)
                       guard durationStatus == .loaded else { fatalError("Failed to load duration property with error: \(String(describing: durationError))") }
                       
                       var playableError: NSError?
                       let playableStatus = videoAsset.statusOfValue(forKey: ObserverContexts.urlAssetPlayableKey, error: &playableError)
                       guard playableStatus == .loaded else { fatalError("Failed to read playable duration property with error: \(String(describing: playableError))") }
                       
                       guard videoAsset.isPlayable else {
                           print("Can't loop since asset is not playable")
                           return
                       }
                       
                       guard CMTimeCompare(videoAsset.duration, CMTime(value:1, timescale:100)) >= 0 else {
                           print("Can't loop since asset duration too short. Duration is(\(CMTimeGetSeconds(videoAsset.duration)) seconds")
                           return
                       }
                           let loopItem = AVPlayerItem(asset: videoAsset)
                           self.player?.insert(loopItem, after: nil)

                   })
               }
        }
    }
    
    func start(in parentLayer: CALayer) {
        stop()
        
        player = AVQueuePlayer()
        playerLayer = AVPlayerLayer(player: player)
        
        guard let playerLayer = playerLayer else { fatalError("Error creating player layer") }
        playerLayer.frame = parentLayer.bounds
        
        parentLayer.addSublayer(playerLayer)
        self.player?.play()
    
    }
    
    func stop() {
        player?.pause()
        stopObserving()
        
        player?.removeAllItems()
        player = nil
        
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
    
    func advanceToNextItem() {
        player?.advanceToNextItem()
    }
    
    // MARK: Convenience
    
    private func startObserving() {
        guard let player = player, !isObserving else { return }
        
        player.addObserver(self, forKeyPath: ObserverContexts.playerStatusKey, options: .new, context: &ObserverContexts.playerStatus)
        player.addObserver(self, forKeyPath: ObserverContexts.currentItemKey, options: .old, context: &ObserverContexts.currentItem)
        player.addObserver(self, forKeyPath: ObserverContexts.currentItemStatusKey, options: .new, context: &ObserverContexts.currentItemStatus)
        
        isObserving = true
    }
    
    private func stopObserving() {
        guard let player = player, isObserving else { return }
        
        player.removeObserver(self, forKeyPath: ObserverContexts.playerStatusKey, context: &ObserverContexts.playerStatus)
        player.removeObserver(self, forKeyPath: ObserverContexts.currentItemKey, context: &ObserverContexts.currentItem)
        player.removeObserver(self, forKeyPath: ObserverContexts.currentItemStatusKey, context: &ObserverContexts.currentItemStatus)
        
        isObserving = false
    }
    
    // MARK: KVO
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &ObserverContexts.playerStatus {
            guard let newPlayerStatus = change?[.newKey] as? AVPlayer.Status else { return }
            
            if newPlayerStatus == AVPlayer.Status.failed {
                print("End looping since player has failed with error: \(String(describing: player?.error))")
                stop()
            }
        }
        else if context == &ObserverContexts.currentItem {
            guard let player = player else { return }
            
            if player.items().isEmpty {
                print("Play queue emptied out due to bad player item. End looping")
                stop()
            }
            else {
                // If `loopCount` has been set, check if looping needs to stop.
                if numberOfTimesToPlay > 0 {
                    numberOfTimesPlayed += 1

                    if numberOfTimesPlayed >= numberOfTimesToPlay {
                        print("Looped \(numberOfTimesToPlay) times. Stopping.");
                        stop()
                    }
                }

                /*
                 Append the previous current item to the player's queue. An initial
                 change from a nil currentItem yields NSNull here. Check to make
                 sure the class is AVPlayerItem before appending it to the end
                 of the queue.
                 */
//                if let itemRemoved = change?[.oldKey] as? AVPlayerItem {
//                    itemRemoved.seek(to: CMTime.zero, completionHandler: nil)
//
//                    stopObserving()
//                    player.insert(itemRemoved, after: nil)
//                    startObserving()
//                }
            }
        }
        else if context == &ObserverContexts.currentItemStatus {
            guard let newPlayerItemStatus = change?[.newKey] as? AVPlayerItem.Status else { return }
            
            if newPlayerItemStatus == .failed {
                print("End looping since player item has failed with error: \(String(describing: player?.currentItem?.error))")
                stop()
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
