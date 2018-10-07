//
//  Bee.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/7/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class Bee: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enemies")
    var initialSize: CGSize = CGSize(width: 28, height: 24)
    var flyAnimation = SKAction()
    
    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        createAnimations()
        self.run(flyAnimation)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        
    }
    
    func createAnimations() {
        let flyFrames: [SKTexture] = [textureAtlas.textureNamed("bee"), textureAtlas.textureNamed("bee-fly")]
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.14)
        flyAnimation = SKAction.repeatForever(flyAction)
    }
    
    func onTap() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
