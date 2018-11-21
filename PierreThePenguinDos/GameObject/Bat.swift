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

    init() {
        super.init(texture: nil, color: .clear, size: CGSize(width: 44, height: 24))
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        if let txtBat = TextureManager.Texture(textureName: TextureName.Bat), let txtBatFly = TextureManager.Texture(textureName: TextureName.BatFly) {
            let flyAction = SKAction.animate(with: [txtBat, txtBatFly], timePerFrame: 0.1)
            let flyAnimation = SKAction.repeatForever(flyAction)
            self.run(flyAnimation)
        }
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue
    }
    
    override func onTap() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
