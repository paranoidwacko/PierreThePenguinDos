//
//  Blade.swift
//  PierreThePenguinDos
//
//  Created by Joaquin Hidalgo on 10/9/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class Blade: GameSprite {
    var spinAnimation = SKAction()
    
    init() {
        super.init(textureAtlas: SKTextureAtlas(named: TextureAtlasName.Enemies.rawValue), textureName: TextureName.Blade, color: .clear, size: CGSize(width: 185, height: 92))
        if let texture = self.texture {
            self.physicsBody = SKPhysicsBody(texture: texture, size: self.size)
        }
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.createAnimations()
        self.run(self.spinAnimation)
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue
    }
    
    func createAnimations() {
        let spinFrames: [SKTexture] = self.Textures(textureNames: [TextureName.Blade, TextureName.Blade2])
        let spinAction = SKAction.animate(with: spinFrames, timePerFrame: 0.07)
        self.spinAnimation = SKAction.repeatForever(spinAction)
    }
    
    override func onTap() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
