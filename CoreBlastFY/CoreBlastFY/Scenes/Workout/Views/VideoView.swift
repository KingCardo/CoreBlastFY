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

    var player: AVQueuePlayer?
    var playerLayer: AVPlayerLayer?

    var urls: [URL]

    init(frame: CGRect, urls: [URL]) {
        self.urls = urls
        super.init(frame: frame)
        configurePlayerItems { [weak self] (success) in
            if success {
                self?.setupVideo()
                self?.playVideo()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var playerItems = [AVPlayerItem]()
    
    private func configurePlayerItems(completion: @escaping(Bool) -> Void) {
        let assetKeys = ["playable"]
        urls.forEach { (url) in
            print(url, "RWRWR")
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: assetKeys)
            playerItems.append(playerItem)

        }
        completion(true)
    }

     private func setupVideo() {
        player = AVQueuePlayer(items: playerItems)
        player?.isMuted = true
        playerLayer = AVPlayerLayer(player: player)
        playerLayer!.frame = self.bounds
        playerLayer!.videoGravity = .resizeAspectFill
        self.layer.addSublayer(playerLayer!)
    }

    func playVideo() {
        player?.play()
        print(player?.status.rawValue, "RWRWRW")
    }

    func pauseVideo() {
        player?.pause()
    }
}
