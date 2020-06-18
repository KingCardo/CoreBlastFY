//
//  MusicPlayer.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 6/18/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicPlayerService {
    static let shared = MusicPlayerService()
    
    private let musicPlayer = MPMusicPlayerController.applicationQueuePlayer
    
    var audioPlayer: AVAudioPlayer?
    
    func startBackgroundMusic(_ mediaPicker: MPMediaPickerController,
                              didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        musicPlayer.setQueue(with: mediaItemCollection)
        musicPlayer.play()
    }
    
    func stopBackgroudMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
}
