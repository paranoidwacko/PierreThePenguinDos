//
//  GameScene.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 9/10/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        
        let mySprite = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 50))
        mySprite.position = CGPoint(x: 150, y: 150)
//        mySprite.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(mySprite)
        
//        let demoAction = SKAction.move(to: CGPoint(x: 300, y: 150), duration: 3)
//        let demoAction = SKAction.scale(to: 4, duration: 5)
        let demoAction1 = SKAction.scale(to: 4, duration: 5)
        let demoAction2 = SKAction.rotate(byAngle: 5, duration: 5)
//        let actionGroup = SKAction.group([demoAction1, demoAction2])
        let actionSequence = SKAction.sequence([demoAction1, demoAction2])
        mySprite.run(actionSequence)
//        mySprite.run(actionGroup)
//        mySprite.run(demoAction)
    }
}
