//
//  Star.swift
//  PierreThePenguinDos
//
//  Created by Joaquin Hidalgo on 10/9/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class Star: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Environment")
    var initialSize: CGSize = CGSize(width: 40, height: 38)
    var pulseAnimation = SKAction()
    
    init() {
        let starTexture = textureAtlas.textureNamed("star")
        super.init(texture: starTexture, color: .clear, size: self.initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        createAnimations()
        self.run(self.pulseAnimation)
    }
    
    func createAnimations() {
        let pulseOutGroup = SKAction.group([
            SKAction.fadeAlpha(by: 0.85, duration: 0.8),
            SKAction.scale(by: 0.6, duration: 0.8),
            SKAction.rotate(byAngle: -0.3, duration: 0.8)
            ])
        let pulseInGroup = SKAction.group([
            SKAction.fadeAlpha(by: 1, duration: 1.5),
            SKAction.scale(by: 1, duration: 1.5),
            SKAction.rotate(byAngle: 3.5, duration: 1.5)
            ])
        let pulseSequence = SKAction.sequence([pulseOutGroup, pulseInGroup])
        self.pulseAnimation = SKAction.repeatForever(pulseSequence)
    }
    
    func onTap() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
