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
        super.init(texture: nil, color: .clear, size: CGSize(width: 185, height: 92))
        if let texture = TextureManager.Texture(textureName: TextureName.Blade) {
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
        if let txtBlade = TextureManager.Texture(textureName: TextureName.Blade), let txtBlade2 = TextureManager.Texture(textureName: TextureName.Blade2) {
            let spinAction = SKAction.animate(with: [txtBlade, txtBlade2], timePerFrame: 0.07)
            self.spinAnimation = SKAction.repeatForever(spinAction)
        }
    }
    
    override func onTap() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
