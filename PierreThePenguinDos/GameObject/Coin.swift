//
//  Coin.swift
//  PierreThePenguinDos
//
//  Created by Joaquin Hidalgo on 10/9/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class Coin: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: TextureAtlasName.Environment.rawValue)
    var initialSize: CGSize = CGSize(width: 26, height: 26)
    var value = 1
    let coinSound = SKAction.playSoundFileNamed("Sound/Coin.aif", waitForCompletion: false)
    
    init() {
        let bronzeTexture = textureAtlas.textureNamed(TextureName.CoinBronze.rawValue)
        super.init(texture: bronzeTexture, color: .clear, size: self.initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
        self.physicsBody?.collisionBitMask = 0
    }
    
    func turnToGold() {
        self.texture = self.textureAtlas.textureNamed(TextureName.CoinGold.rawValue)
        self.value = 5
    }
    
    func onTap() {
        
    }
    
    func collect() {
        self.physicsBody?.categoryBitMask = 0
        let collectAnimation = SKAction.group([
            SKAction.fadeAlpha(by: 0, duration: 0.2),
            SKAction.scale(by: 1.5, duration: 0.2),
            SKAction.move(by: CGVector(dx: 0, dy: 25), duration: 0.2)
            ])
        let resetAfterCollected = SKAction.run {
            self.position.y = 5000
            self.alpha = 1
            self.xScale = 1
            self.yScale = 1
            self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
        }
        let collectSequence = SKAction.sequence([
            collectAnimation,
            resetAfterCollected
            ])
        self.run(collectSequence)
        self.run(coinSound)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
