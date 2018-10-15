//
//  MadFly.swift
//  PierreThePenguinDos
//
//  Created by Joaquin Hidalgo on 10/9/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class MadFly: GameSprite {
    var flyAnimation = SKAction()
    
    init() {
        super.init(textureAtlas: SKTextureAtlas(named: TextureAtlasName.Enemies.rawValue), textureName: nil, color: .clear, size: CGSize(width: 61, height: 29))
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        createAnimations()
        self.run(self.flyAnimation)
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue
    }
    
    func createAnimations() {
        let flyFrames: [SKTexture] = self.Textures(textureNames: [TextureName.MadFly, TextureName.MadFlyFly])
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.14)
        self.flyAnimation = SKAction.repeatForever(flyAction)
    }
    
    override func onTap() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
