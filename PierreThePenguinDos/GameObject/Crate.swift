//
//  Crate.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/13/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class Crate: GameSprite {
    var givesHeart = false
    var exploded = false
    
    init() {
        super.init(textureAtlas: SKTextureAtlas(named: TextureAtlasName.Environment.rawValue), textureName: TextureName.Crate, color: UIColor.clear, size: CGSize(width: 40, height: 40))
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.collisionBitMask = PhysicsCategory.ground.rawValue | PhysicsCategory.crate.rawValue
        self.physicsBody?.categoryBitMask = PhysicsCategory.crate.rawValue
    }
    
    func turnToHeartCrate() {
        self.physicsBody?.affectedByGravity = false
        self.Texture(textureName: TextureName.CratePowerUp)
        self.givesHeart = true
    }
    
    func explode(gameScene: GameScene) {
        if exploded {
            return
        }
        exploded = true
        gameScene.particlePool.placeEmitter(node: self, emitterType: EmitterType.Crate.rawValue)
        self.run(SKAction.fadeAlpha(to: 0, duration: 0.1))
        
        if (givesHeart) {
            let newHealth = gameScene.player.health + 1
            let maxHealth = gameScene.player.maxHealth
            gameScene.player.health = newHealth > maxHealth ? maxHealth : newHealth
            gameScene.hud.setHealthDisplay(newHealth: gameScene.player.health)
            gameScene.particlePool.placeEmitter(node: self, emitterType: EmitterType.Heart.rawValue)
        } else {
            gameScene.coinsCollected += 25
            gameScene.hud.setCoinCountDisplay(newCoinCount: gameScene.coinsCollected)
        }
        self.physicsBody?.categoryBitMask = 0
    }
    
    func reset() {
        self.alpha = 1
        self.physicsBody?.categoryBitMask = PhysicsCategory.crate.rawValue
        exploded = false
    }
    
    override func onTap() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
