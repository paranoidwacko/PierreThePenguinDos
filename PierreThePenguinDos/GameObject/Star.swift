//
//  Star.swift
//  PierreThePenguinDos
//
//  Created by Joaquin Hidalgo on 10/9/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class Star: GameSprite {
    fileprivate var pulseAnimation = SKAction()
    
    init() {
        super.init(texture: TextureManager.Texture(textureName: TextureName.Star), color: .clear, size: CGSize(width: 40, height: 38))
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        createAnimations()
        self.run(self.pulseAnimation)
        self.physicsBody?.categoryBitMask = PhysicsCategory.powerup.rawValue
    }
    
    func createAnimations() {
        let pulseOutGroup = SKAction.group([
            SKAction.fadeAlpha(to: 0.85, duration: 0.8),
            SKAction.scale(to: 0.6, duration: 0.8),
            SKAction.rotate(byAngle: -0.3, duration: 0.8)
            ])
        let pulseInGroup = SKAction.group([
            SKAction.fadeAlpha(to: 1, duration: 1.5),
            SKAction.scale(to: 1, duration: 1.5),
            SKAction.rotate(byAngle: 3.5, duration: 1.5)
            ])
        let pulseSequence = SKAction.sequence([pulseOutGroup, pulseInGroup])
        self.pulseAnimation = SKAction.repeatForever(pulseSequence)
    }
    
    override func onTap() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
