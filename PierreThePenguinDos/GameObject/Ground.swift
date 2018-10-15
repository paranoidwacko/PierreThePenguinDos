//
//  Ground.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/7/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class Ground: GameSprite {
    var jumpWidth = CGFloat()
    var jumpCount = CGFloat(1)
    
    init() {
        super.init(textureAtlas: SKTextureAtlas(named: TextureAtlasName.Environment.rawValue), textureName: nil, color: UIColor.clear, size: CGSize.zero)
    }
    
    func createChildren() {
        self.anchorPoint = CGPoint(x: 0, y: 1)
        self.Texture(textureName: TextureName.Ground)
        var tileCount: CGFloat = 0
        let tileSize = CGSize(width: 35, height: 300)
        while tileCount * tileSize.width < self.size.width {
            let tileNode = SKSpriteNode(texture: texture)
            tileNode.size = tileSize
            tileNode.position.x = tileCount * tileSize.width
            tileNode.anchorPoint = CGPoint(x: 0, y: 1)
            self.addChild(tileNode)
            tileCount += 1
        }
        let pointTopLeft = CGPoint(x: 0, y: 0)
        let pointTopRight = CGPoint(x: size.width, y: 0)
        self.physicsBody = SKPhysicsBody(edgeFrom: pointTopLeft, to: pointTopRight)
        
        self.jumpWidth = tileSize.width * floor(tileCount / 3)
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
    }
    
    func checkForReposition(playerProgress: CGFloat) {
        let groundJumpPosition = jumpWidth * jumpCount
        
        if playerProgress >= groundJumpPosition {
            self.position.x += jumpWidth
            jumpCount += 1
        }
    }
    
    override func onTap() { }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
