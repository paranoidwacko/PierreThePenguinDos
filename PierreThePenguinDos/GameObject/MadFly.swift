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
    fileprivate var flyAnimation = SKAction()
    
    init() {
        super.init(texture: nil, color: .clear, size: CGSize(width: 61, height: 29))
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        createAnimations()
        self.run(self.flyAnimation)
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue
    }
    
    func createAnimations() {
        if let txtMadFly = TextureManager.Texture(textureName: TextureName.MadFly), let txtMadFlyFly = TextureManager.Texture(textureName: TextureName.MadFlyFly) {
            let flyAction = SKAction.animate(with: [txtMadFly, txtMadFlyFly], timePerFrame: 0.14)
            self.flyAnimation = SKAction.repeatForever(flyAction)
        }
        
    }
    
    override func onTap() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
