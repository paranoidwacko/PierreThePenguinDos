//
//  AudioManager.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/14/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import SpriteKit
import GameKit

class AudioManager {
    fileprivate static let pInstance: AudioManager = AudioManager()
    fileprivate var audios: [AudioName: SKAction]
    fileprivate var backgroundMusicPlayer: AVAudioPlayer?
    
    fileprivate init() {
        self.audios = [AudioName: SKAction]()
        self.audios[AudioName.Coin]      = SKAction.playSoundFileNamed(AudioName.Coin.rawValue, waitForCompletion: false)
        self.audios[AudioName.GameStart] = SKAction.playSoundFileNamed(AudioName.GameStart.rawValue, waitForCompletion: false)
        self.audios[AudioName.Hurt]      = SKAction.playSoundFileNamed(AudioName.Hurt.rawValue, waitForCompletion: false)
        self.audios[AudioName.PowerUp]   = SKAction.playSoundFileNamed(AudioName.PowerUp.rawValue, waitForCompletion: false)
        
        if let musicPath = Bundle.main.path(forResource: AudioName.BackgroundMusic.rawValue, ofType: nil) {
            let url = URL(fileURLWithPath: musicPath)
            do {
                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                self.backgroundMusicPlayer?.numberOfLoops = -1
                self.backgroundMusicPlayer?.prepareToPlay()
            } catch {}
        }
    }
    
    public static func AudioAction(of name: AudioName) -> SKAction? {
        return pInstance.audios[name]
    }
    
    public static func PlayBackground() {
        pInstance.backgroundMusicPlayer?.play()
    }
    
}
