//
//  GameScene.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 9/10/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    let cam = SKCameraNode()
    let ground = Ground()
    let player = Player()
//    let motionManager = CMMotionManager()
    var screenCenterY = CGFloat()
    let initialPlayerPostion = CGPoint(x: 150, y: 250)
    var playerProgress = CGFloat()
    let encounterManager = EncounterManager()
    var nextEncounterSpawnPosition = CGFloat(150)
    let powerUpStar = Star()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        self.camera = self.cam
        
        self.ground.position = CGPoint(x: -self.size.width * 2, y: 30)
        self.ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.createChildren()
        self.addChild(self.ground)
        
        self.player.position = self.initialPlayerPostion
        self.addChild(self.player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
//        self.motionManager.startAccelerometerUpdates()
        
        self.screenCenterY = self.size.height / 2
        
        self.encounterManager.addEncountersToScene(gameScene: self)
        
        self.addChild(powerUpStar)
        powerUpStar.position = CGPoint(x: -2000, y: -2000)
        
        self.physicsWorld.contactDelegate = self
    }
    
    override func didSimulatePhysics() {
        var cameraYPos = self.screenCenterY
        self.cam.yScale = 1
        self.cam.xScale = 1
        
        if (player.position.y > screenCenterY) {
            cameraYPos = player.position.y
            let percentOfMaxHeight = (player.position.y - screenCenterY) / (player.maxHeight - screenCenterY)
            let newScale = 1 + percentOfMaxHeight
            cam.yScale = newScale
            cam.xScale = newScale
        }
        
        if let myCam = self.camera {
            myCam.position = CGPoint(x: player.position.x, y: cameraYPos)
        }
        
        self.playerProgress = player.position.x - initialPlayerPostion.x
        
        self.ground.checkForReposition(playerProgress: self.playerProgress)
        
        if player.position.x > nextEncounterSpawnPosition {
            encounterManager.placeNextEncounter(currentXPos: nextEncounterSpawnPosition)
            nextEncounterSpawnPosition += 1200
            
            let starRoll = Int(arc4random_uniform(10))
            if starRoll == 0 {
                if abs(player.position.x - powerUpStar.position.x) > 1200 {
                    let randomYPos = 50 + CGFloat(arc4random_uniform(400))
                    powerUpStar.position = CGPoint(x: nextEncounterSpawnPosition, y: randomYPos)
                    powerUpStar.physicsBody?.angularVelocity = 0
                    powerUpStar.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                }
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.update()
        
//        if let accelData = self.motionManager.accelerometerData {
//            var forceAmount: CGFloat
//            var movement = CGVector()
//
//            switch UIApplication.shared.statusBarOrientation {
//            case .landscapeLeft:
//                forceAmount = 20000
//            case .landscapeRight:
//                forceAmount = -20000
//            default:
//                forceAmount = 0
//            }
//
//            if accelData.acceleration.y > 0.15 {
//                movement.dx = forceAmount
//            } else if accelData.acceleration.y < -0.15 {
//                movement.dx = -forceAmount
//            }
//            player.physicsBody?.applyForce(movement)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.player.startFlapping()
//        for touch in touches {
//            let location = touch.location(in: self)
//            let nodeTouched = atPoint(location)
//            if let gameSprite = nodeTouched as? GameSprite {
//                gameSprite.onTap()
//            }
//        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.player.stopFlapping()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.player.stopFlapping()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let otherBody: SKPhysicsBody
        let penguinMask = PhysicsCategory.penguin.rawValue | PhysicsCategory.damagedPenguin.rawValue
        if (contact.bodyA.categoryBitMask & penguinMask) > 0 {
            otherBody = contact.bodyB
        } else {
            otherBody = contact.bodyA
        }
        switch otherBody.categoryBitMask {
        case PhysicsCategory.ground.rawValue:
            print("HIT THE GROUND")
        case PhysicsCategory.enemy.rawValue:
            print("Take damage")
        case PhysicsCategory.coin.rawValue:
            print("Collect a coin")
        case PhysicsCategory.powerup.rawValue:
            print("Start the power-up")
        default:
            print("Contact with no game logic")
        }
    }
}
