//
//  AudioPlayer.swift
//  Maths Tutor
//
//  Created by Theo Ntogiakos on 20/11/2023.
//

import SwiftUI
import AVFAudio

class AudioPlayer {
    private var audioPlayer: AVAudioPlayer!

    func play(clip name: String) {
        guard let audioClip = NSDataAsset(name: name) else {
            print("Couldn't find \(name)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: audioClip.data)
            audioPlayer?.play()
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
}
