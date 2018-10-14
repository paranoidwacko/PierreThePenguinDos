//
//  HUD.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/13/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class HUD: SKNode {
    public static let NAME_BUTTON_MENU: String = "returnToMenu"
    public static let NAME_BUTTON_RESTART: String = "restartGame"
    fileprivate static let TEXT_INITIAL_COIN_COUNT: String = "000000"
    
    var textureAtlas = SKTextureAtlas(named: TextureAtlasName.HUD.rawValue)
    var coinAtlas = SKTextureAtlas(named: TextureAtlasName.Environment.rawValue)
    var heartNodes: [SKSpriteNode] = []
    let coinCountText = SKLabelNode(text: HUD.TEXT_INITIAL_COIN_COUNT)
    let restartButton = SKSpriteNode()
    let menuButton = SKSpriteNode()
    
    func createHUDNodes(screenSize: CGSize) {
        let cameraOrigin = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        let coinIcon = SKSpriteNode(texture: coinAtlas.textureNamed(TextureName.CoinBronze.rawValue))
        let coinPosition = CGPoint(x: -cameraOrigin.x + 23, y: cameraOrigin.y - 23)
        coinIcon.size = CGSize(width: 26, height: 26)
        coinIcon.position = coinPosition
        coinCountText.fontName = FontName.AvenirNextHeavyItalic.rawValue
        let coinTextPosition = CGPoint(x: -cameraOrigin.x + 41, y: coinPosition.y)
        coinCountText.position = coinTextPosition
        coinCountText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        coinCountText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.addChild(coinCountText)
        self.addChild(coinIcon)
        for index in 0..<3 {
            let newHeartNode = SKSpriteNode(texture: textureAtlas.textureNamed(TextureName.HeartFull.rawValue))
            newHeartNode.size = CGSize(width: 46, height: 40)
            let xPos = -cameraOrigin.x + CGFloat(index * 58) + 33
            let yPos = cameraOrigin.y - 66
            newHeartNode.position = CGPoint(x: xPos, y: yPos)
            heartNodes.append(newHeartNode)
            self.addChild(newHeartNode)
        }
        
        restartButton.texture = textureAtlas.textureNamed(TextureName.ButtonRestart.rawValue)
        menuButton.texture = textureAtlas.textureNamed(TextureName.ButtonMenu.rawValue)
        restartButton.name = HUD.NAME_BUTTON_RESTART
        menuButton.name = HUD.NAME_BUTTON_MENU
        menuButton.position = CGPoint(x: -140, y: 0)
        restartButton.size = CGSize(width: 140, height: 140)
        menuButton.size = CGSize(width: 70, height: 70)
    }
    
    func setCoinCountDisplay(newCoinCount: Int) {
        let formatter = NumberFormatter()
        let number = NSNumber(value: newCoinCount)
        formatter.minimumIntegerDigits = 6
        if let coinStr = formatter.string(from: number) {
            coinCountText.text = coinStr
        }
    }
    
    func setHealthDisplay(newHealth: Int) {
        let fadeAction = SKAction.fadeAlpha(to: 0.2, duration: 0.3)
        for index in 0..<heartNodes.count {
            if index < newHealth {
                heartNodes[index].alpha = 1
            } else {
                heartNodes[index].run(fadeAction)
            }
        }
    }
    
    func showButtons() {
        restartButton.alpha = 0
        menuButton.alpha = 0
        self.addChild(restartButton)
        self.addChild(menuButton)
        let fadeAnimation = SKAction.fadeAlpha(to: 1, duration: 0.4)
        restartButton.run(fadeAnimation)
        menuButton.run(fadeAnimation)
    }
}
