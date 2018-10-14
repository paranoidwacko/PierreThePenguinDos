//
//  GameScene.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 9/10/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import SpriteKit
import GameKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let cam = SKCameraNode()
    let ground = Ground()
    let player = Player()
    var screenCenterY = CGFloat()
    let initialPlayerPostion = CGPoint(x: 150, y: 250)
    var playerProgress = CGFloat()
    let encounterManager = EncounterManager()
    var nextEncounterSpawnPosition = CGFloat(150)
    let powerUpStar = Star()
    var coinsCollected = 0
    let hud = HUD()
    var backgrounds: [Background] = []
    let particlePool = ParticlePool()
    let heartCrate = Crate()
    
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
        
        self.screenCenterY = self.size.height / 2
        
        self.encounterManager.addEncountersToScene(gameScene: self)
        
        self.addChild(powerUpStar)
        powerUpStar.position = CGPoint(x: -2000, y: -2000)
        
        self.physicsWorld.contactDelegate = self
        
        self.addChild(self.camera!)
        self.camera?.zPosition = 50
        hud.createHUDNodes(screenSize: self.size)
        self.camera?.addChild(hud)
        
        for _ in 0..<3 {
            backgrounds.append(Background())
        }
        backgrounds[0].spawn(parentNode: self, imageName: TextureName.BackgroundFront.rawValue, zPosition: -5, movementMultiplier: 0.75)
        backgrounds[1].spawn(parentNode: self, imageName: TextureName.BackgroundMiddle.rawValue, zPosition: -10, movementMultiplier: 0.5)
        backgrounds[2].spawn(parentNode: self, imageName: TextureName.BackgroundBack.rawValue, zPosition: -15, movementMultiplier: 0.2)
        
        if let dotEmitter = SKEmitterNode(fileNamed: "PierrePath") {
            player.zPosition = 10
            dotEmitter.particleZPosition = -1
            player.addChild(dotEmitter)
            dotEmitter.targetNode = self
        }
        
        self.particlePool.addEmittersToScene(scene: self)
        
        self.addChild(self.heartCrate)
        heartCrate.position = CGPoint(x: -2100, y: -2100)
        heartCrate.turnToHeartCrate()
        
        self.run(SKAction.playSoundFileNamed("Sound/StartGame.aif", waitForCompletion: false))
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
            if starRoll == 1 {
                heartCrate.reset()
                heartCrate.position = CGPoint(x: nextEncounterSpawnPosition - 600, y: 270)
            }
        }
        
        for background in self.backgrounds {
            background.updatePosition(playerProgress: playerProgress)
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
        for touch in touches {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if let gameSprite = nodeTouched as? GameSprite {
                gameSprite.onTap()
            }
            
            if nodeTouched.name == "restartGame" {
                self.view?.presentScene(GameScene(size: self.size), transition: .crossFade(withDuration: 0.6))
            } else if nodeTouched.name == "returnToMen" {
                self.view?.presentScene(MenuScene(size: self.size), transition: .crossFade(withDuration: 0.6))
            }
        }
        self.player.startFlapping()

////        for touch in touches {
////            let location = touch.location(in: self)
////            let nodeTouched = atPoint(location)
////            if let gameSprite = nodeTouched as? GameSprite {
////                gameSprite.onTap()
////            }
////        }
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
            player.takeDamage()
            hud.setHealthDisplay(newHealth: player.health)
        case PhysicsCategory.enemy.rawValue:
            self.player.takeDamage()
            hud.setHealthDisplay(newHealth: player.health)
        case PhysicsCategory.coin.rawValue:
            if let coin = otherBody.node as? Coin {
                coin.collect()
                self.coinsCollected += coin.value
                hud.setCoinCountDisplay(newCoinCount: self.coinsCollected)
            }
        case PhysicsCategory.powerup.rawValue:
            self.player.starPower()
        case PhysicsCategory.crate.rawValue:
            if let crate = otherBody.node as? Crate {
                crate.explode(gameScene: self)
            }
        default:
            return
        }
    }
    
    func gameOver() {
        hud.showButtons()
        updateLeaderboard()
        checkForAchievements()
    }
    
    func updateLeaderboard() {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let score = GKScore(leaderboardIdentifier: "pierre_the_penguin_coin_count")
            score.value = Int64(self.coinsCollected)
            GKScore.report([score], withCompletionHandler: { (error: Error?) -> Void in
                if error != nil {
                    print(error!)
                }
            })
        }
    }
    
    func checkForAchievements() {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            if self.coinsCollected >= 100 {
                let achieve = GKAchievement(identifier: "100_coins")
                achieve.showsCompletionBanner = true
                achieve.percentComplete = 100
                GKAchievement.report([achieve], withCompletionHandler: {(error : Error?) -> Void in
                    if error != nil {
                        print(error!)
                    }
                })
            }
        }
    }
}
