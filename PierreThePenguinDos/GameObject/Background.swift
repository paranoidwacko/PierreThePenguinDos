//
//  Background.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/13/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode {
    fileprivate var movementMultiplier = CGFloat(0)
    fileprivate var jumpAdjustment = CGFloat(0)
    fileprivate let backgroundSize = CGSize(width: 1024, height: 768)
    
    func spawn(parentNode: SKNode, textureName: TextureName, zPosition: CGFloat, movementMultiplier: CGFloat) {
        self.anchorPoint = CGPoint.zero
        self.position = CGPoint(x: 0, y: 30)
        self.zPosition = zPosition
        self.movementMultiplier = movementMultiplier
        parentNode.addChild(self)
        let texture = TextureManager.Texture(textureName: textureName)
        for i in -1...1 {
            let newBGNode = SKSpriteNode(texture: texture)
            newBGNode.size = backgroundSize
            newBGNode.anchorPoint = CGPoint.zero
            newBGNode.position = CGPoint(x: i * Int(backgroundSize.width), y: 0)
            self.addChild(newBGNode)
        }
    }
    
    func updatePosition(playerProgress: CGFloat) {
        let adjustedPosition = jumpAdjustment + playerProgress * (1 - movementMultiplier)
        if playerProgress - adjustedPosition > backgroundSize.width {
            jumpAdjustment += backgroundSize.width
        }
        self.position.x = adjustedPosition
    }
}
