//
//  GameScene.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 9/10/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    let cam = SKCameraNode()
    let ground = Ground()
    let player = Player()
//    let motionManager = CMMotionManager()
    var screenCenterY = CGFloat()
    let initialPlayerPostion = CGPoint(x: 150, y: 250)
    var playerProgress = CGFloat()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        self.camera = self.cam
        
        let bee2 = Bee()
        bee2.position = CGPoint(x: 325, y: 325)
        self.addChild(bee2)
        let bee3 = Bee()
        bee3.position = CGPoint(x: 200, y: 325)
        self.addChild(bee3)
        
        
        let bat = Bat()
        bat.position = CGPoint(x: 400, y: 200)
        self.addChild(bat)
        
        let blade = Blade()
        blade.position = CGPoint(x: 300, y: 76)
        self.addChild(blade)
        
        let madFly = MadFly()
        madFly.position = CGPoint(x: 50, y: 50)
        self.addChild(madFly)
        
        let bronzeCoin = Coin()
        bronzeCoin.position = CGPoint(x: -50, y: 250)
        self.addChild(bronzeCoin)
        
        let goldCoin = Coin()
        goldCoin.position = CGPoint(x: 25, y: 250)
        goldCoin.turnToGold()
        self.addChild(goldCoin)
        
        let star = Star()
        star.position = CGPoint(x: 250, y: 250)
        self.addChild(star)
        
        
        
        
        
        
        
        
        
        self.ground.position = CGPoint(x: -self.size.width * 2, y: 30)
        self.ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.createChildren()
        self.addChild(self.ground)
        
        self.player.position = self.initialPlayerPostion
        self.addChild(self.player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
//        self.motionManager.startAccelerometerUpdates()
        
        self.screenCenterY = self.size.height / 2
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
}
