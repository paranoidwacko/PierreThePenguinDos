//
//  Bats.swift
//  PierreThePenguinDos
//
//  Created by Joaquin Hidalgo on 10/9/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class Bat: GameSprite {
    var flyAnimation = SKAction()
    
    init() {
        super.init(textureAtlas: SKTextureAtlas(named: TextureAtlasName.Enemies.rawValue), textureName: nil, color: .clear, size: CGSize(width: 44, height: 24))
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.createAnimations()
        self.run(self.flyAnimation)
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue
    }
    
    func createAnimations() {
        let flyFrames: [SKTexture] = self.Textures(textureNames: [TextureName.Bat, TextureName.BatFly])
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.12)
        self.flyAnimation = SKAction.repeatForever(flyAction)
    }
    
    override func onTap() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
