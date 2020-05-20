//
//  SpeechSynthesizer.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/20/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import AVFoundation

class SpeechSynthesizer {
    
    static var shared = SpeechSynthesizer()
    
    var speechSynthesizer = AVSpeechSynthesizer()
    
    func textToSpeak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        let voices = AVSpeechSynthesisVoice.speechVoices()
        let voice = voices[10]
        utterance.voice = voice
        self.speechSynthesizer.speak(utterance)
    }
}
