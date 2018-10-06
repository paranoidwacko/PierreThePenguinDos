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
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        
        let bee = SKSpriteNode()
        bee.size = CGSize(width: 28, height: 24)
        bee.position = CGPoint(x: 250, y: 250)
        self.addChild(bee)
        
        let beeAtlas = SKTextureAtlas(named: "Enemies")
        let beeFrames:[SKTexture] = [
        beeAtlas.textureNamed("bee"),
        beeAtlas.textureNamed("bee-fly")]
        let flyAction = SKAction.animate(with: beeFrames, timePerFrame: 0.14)
        let beeAction = SKAction.repeatForever(flyAction)
        bee.run(beeAction)
        
        let pathLeft = SKAction.moveBy(x: -200, y: -10, duration: 2)
        let pathRight = SKAction.moveBy(x: 200, y: 10, duration: 2)
        let flipTextureNegative = SKAction.scaleX(to: -1, duration: 0)
        let flipTexturePositive = SKAction.scaleX(to: 1, duration: 0)
        let flightOfTheBee = SKAction.sequence([pathLeft, flipTextureNegative, pathRight, flipTexturePositive])
        let neverEndingFlight = SKAction.repeatForever(flightOfTheBee)
        bee.run(neverEndingFlight)
        
//        self.anchorPoint = .zero
//        let mySprite = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 50))
//        mySprite.position = CGPoint(x: 150, y: 150)
////        mySprite.anchorPoint = CGPoint(x: 0, y: 0)
//        self.addChild(mySprite)
//
////        let demoAction = SKAction.move(to: CGPoint(x: 300, y: 150), duration: 3)
////        let demoAction = SKAction.scale(to: 4, duration: 5)
//        let demoAction1 = SKAction.scale(to: 4, duration: 5)
//        let demoAction2 = SKAction.rotate(byAngle: 5, duration: 5)
////        let actionGroup = SKAction.group([demoAction1, demoAction2])
//        let actionSequence = SKAction.sequence([demoAction1, demoAction2])
//        mySprite.run(actionSequence)
////        mySprite.run(actionGroup)
////        mySprite.run(demoAction)
    }
}
