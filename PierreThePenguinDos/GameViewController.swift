//
//  GameViewController.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 9/10/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import GameKit

class GameViewController: UIViewController {
    var musicPlayer = AVAudioPlayer()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if let musicPath = Bundle.main.path(forResource: "Sound/BackgroundMusic.m4a", ofType: nil) {
            let url = URL(fileURLWithPath: musicPath)
            do {
                self.musicPlayer = try AVAudioPlayer(contentsOf: url)
                musicPlayer.numberOfLoops = -1
                musicPlayer.prepareToPlay()
                musicPlayer.play()
            } catch {}
        }
        
        let menuScene = MenuScene()
        if let skView = self.view as? SKView {
            skView.ignoresSiblingOrder = true
            menuScene.size = view.bounds.size
            skView.presentScene(menuScene)
        }
        
        authenticateLocalPlayer(menuScene: menuScene)
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func authenticateLocalPlayer(menuScene: MenuScene) {
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = { (viewController, error) -> Void in
            if viewController != nil {
                self.present(viewController!, animated: true, completion: nil)
            } else if localPlayer.isAuthenticated {
                menuScene.createLeaderboardButton()
            } else {
                
            }
        }
    }
}
