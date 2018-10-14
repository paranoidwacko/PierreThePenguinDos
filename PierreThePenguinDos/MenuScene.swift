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
    fileprivate static let KEY_BUTTON_LEADERBOARD = "LeaderboardBtn"
    fileprivate static let KEY_BUTTON_START = "StartBtn"
    fileprivate static let TEXT_APP_TITLE = NSLocalizedString("app_title", comment: "")
    fileprivate static let TEXT_APP_SUBTITLE = NSLocalizedString("app_subtitle", comment: "")
    fileprivate static let TEXT_MENU_BUTTON_LEADERBOARD = NSLocalizedString("menu_button_leaderboard", comment: "")
    fileprivate static let TEXT_MENU_BUTTON_START = NSLocalizedString("menu_button_start", comment: "")
    
    
    let textureAtlas: SKTextureAtlas = SKTextureAtlas(named: TextureAtlasName.HUD.rawValue)
    let startButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let backgroundImage = SKSpriteNode(imageNamed: TextureName.BackgroundMenu.rawValue)
        backgroundImage.size = CGSize(width: 1024, height: 768)
        backgroundImage.zPosition = -1
        self.addChild(backgroundImage)
        
        let logoText = SKLabelNode(fontNamed: FontName.AvenirNextHeavy.rawValue)
        logoText.text = MenuScene.TEXT_APP_TITLE
        logoText.position = CGPoint(x: 0, y: 100)
        logoText.fontSize = 60
        self.addChild(logoText)
        let logoTextBottom = SKLabelNode(fontNamed: FontName.AvenirNextHeavy.rawValue)
        logoTextBottom.text = MenuScene.TEXT_APP_SUBTITLE
        logoTextBottom.position = CGPoint(x: 0, y: 50)
        logoTextBottom.fontSize = 40
        self.addChild(logoTextBottom)
        
        startButton.texture = textureAtlas.textureNamed(TextureName.Button.rawValue)
        startButton.size = CGSize(width: 295, height: 76)
        startButton.name = MenuScene.KEY_BUTTON_START
        startButton.position = CGPoint(x: 0, y: -20)
        self.addChild(startButton)
        
        let startText = SKLabelNode(fontNamed: FontName.AvenirNextHeavyItalic.rawValue)
        startText.text = MenuScene.TEXT_MENU_BUTTON_START
        startText.verticalAlignmentMode = .center
        startText.position = CGPoint(x: 0, y: 2)
        startText.fontSize = 40
        startText.name = MenuScene.KEY_BUTTON_START
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
            if nodeTouched.name == MenuScene.KEY_BUTTON_START {
                self.view?.presentScene(GameScene(size: self.size))
            } else if nodeTouched.name == MenuScene.KEY_BUTTON_LEADERBOARD {
                showLeaderboard()
            }
        }
    }
    
    func createLeaderboardButton() {
        let leaderboardText = SKLabelNode(fontNamed: FontName.AvenirNext.rawValue)
        leaderboardText.text = MenuScene.TEXT_MENU_BUTTON_LEADERBOARD
        leaderboardText.name = MenuScene.KEY_BUTTON_LEADERBOARD
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
