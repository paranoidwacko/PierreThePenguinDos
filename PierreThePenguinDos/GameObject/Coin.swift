//
//  Coin.swift
//  PierreThePenguinDos
//
//  Created by Joaquin Hidalgo on 10/9/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class Coin: GameSprite {
    var value = 1
    
    init() {
        super.init(textureAtlas: SKTextureAtlas(named: TextureAtlasName.Environment.rawValue), textureName: TextureName.CoinBronze, color: .clear, size: CGSize(width: 26, height: 26))
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
        self.physicsBody?.collisionBitMask = 0
    }
    
    func turnToGold() {
        self.Texture(textureName: TextureName.CoinGold)
        self.value = 5
    }
    
    override func onTap() { }
    
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
        if let audioAction = AudioManager.AudioAction(of: AudioName.Coin) {
            self.run(audioAction)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
