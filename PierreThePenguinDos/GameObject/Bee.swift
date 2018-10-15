//
//  Bee.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/7/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class Bee: GameSprite {
    var flyAnimation = SKAction()
    
    init() {
        super.init(texture: nil, color: .clear, size: CGSize(width: 28, height: 24))
        createAnimations()
        self.run(flyAnimation)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue
    }
    
    func createAnimations() {
        if let txtBee = TextureManager.Texture(textureName: TextureName.Bee), let txtBeeFly = TextureManager.Texture(textureName: TextureName.BeeFly) {
            let flyAction = SKAction.animate(with: [txtBee, txtBeeFly], timePerFrame: 0.14)
            flyAnimation = SKAction.repeatForever(flyAction)
        }
    }
    
    override func onTap() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
