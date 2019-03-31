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
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        AudioManager.PlayBackground()
        
        let menuScene = MenuScene(size: CGSize.zero)
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
        let localPlayer = GKLocalPlayer.local
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
