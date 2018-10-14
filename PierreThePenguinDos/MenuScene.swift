//
//  MenuScene.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/13/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

class MenuScene: SKScene, GKGameCenterControllerDelegate {
    let textureAtlas: SKTextureAtlas = SKTextureAtlas(named: TextureAtlasName.HUD.rawValue)
    let startButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let backgroundImage = SKSpriteNode(imageNamed: TextureName.BackgroundMenu.rawValue)
        backgroundImage.size = CGSize(width: 1024, height: 768)
        backgroundImage.zPosition = -1
        self.addChild(backgroundImage)
        
        let logoText = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        logoText.text = "Pierre Penguin"
        logoText.position = CGPoint(x: 0, y: 100)
        logoText.fontSize = 60
        self.addChild(logoText)
        let logoTextBottom = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        logoTextBottom.text = "Escapes the Antarctic"
        logoTextBottom.position = CGPoint(x: 0, y: 50)
        logoTextBottom.fontSize = 40
        self.addChild(logoTextBottom)
        
        startButton.texture = textureAtlas.textureNamed(TextureName.Button.rawValue)
        startButton.size = CGSize(width: 295, height: 76)
        startButton.name = "StartBtn"
        startButton.position = CGPoint(x: 0, y: -20)
        self.addChild(startButton)
        
        let startText = SKLabelNode(fontNamed: "AvenirNext-HeavyItalic")
        startText.text = "START GAME"
        startText.verticalAlignmentMode = .center
        startText.position = CGPoint(x: 0, y: 2)
        startText.fontSize = 40
        startText.name = "StartBtn"
        startText.zPosition = 5
        startButton.addChild(startText)
        
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.5, duration: 0.9),
            SKAction.fadeAlpha(to: 1, duration: 0.9)
            ])
        startText.run(SKAction.repeatForever(pulseAction))
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            self.createLeaderboardButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "StartBtn" {
                self.view?.presentScene(GameScene(size: self.size))
            } else if nodeTouched.name == "LeaderboardBtn" {
                showLeaderboard()
            }
        }
    }
    
    func createLeaderboardButton() {
        let leaderboardText = SKLabelNode(fontNamed: "AvenirNext")
        leaderboardText.text = "Leaderboard"
        leaderboardText.name = "LeaderboardBtn"
        leaderboardText.position = CGPoint(x: 0, y: -100)
        leaderboardText.fontSize = 20
        self.addChild(leaderboardText)
    }
    
    func showLeaderboard() {
        let gameCenter = GKGameCenterViewController()
        gameCenter.gameCenterDelegate = self
        gameCenter.viewState = GKGameCenterViewControllerState.leaderboards
        if let gameViewController = self.view?.window?.rootViewController {
            gameViewController.show(gameCenter, sender: self)
            gameViewController.navigationController?.pushViewController(gameCenter, animated: true)
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
