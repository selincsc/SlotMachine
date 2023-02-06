//
//  PlaySound.swift
//  SlotMachine
//
//  Created by Selin Çağlar on 6.02.2023.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch{
            print("ERROR: COuld not find and play the sound file!")
        }
    }
}
