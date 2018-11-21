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
    fileprivate static let KEY_CHALLENGE_100_COINS = "100_coins"
    fileprivate static let KEY_LEADERBOARD_ID = "pierre_the_penguin_coin_count"    
    
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
//    let heartCrate2 = Crate()
    
    override func didMove(to view: SKView) {
        self.hud.delegate = self
        
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
        backgrounds[0].spawn(parentNode: self, textureName: TextureName.BackgroundFront, zPosition: -5, movementMultiplier: 0.75)
        backgrounds[1].spawn(parentNode: self, textureName: TextureName.BackgroundMiddle, zPosition: -10, movementMultiplier: 0.5)
        backgrounds[2].spawn(parentNode: self, textureName: TextureName.BackgroundBack, zPosition: -15, movementMultiplier: 0.2)
        
        if let dotEmitter = SKEmitterNode(fileNamed: ParticleName.PierrePath.rawValue) {
            player.zPosition = 10
            dotEmitter.particleZPosition = -1
            player.addChild(dotEmitter)
            dotEmitter.targetNode = self
        }
        
        self.particlePool.addEmittersToScene(scene: self)
        
        self.addChild(self.heartCrate)
        heartCrate.position = CGPoint(x: -2100, y: -2100)
        heartCrate.turnToHeartCrate()
        
//        self.addChild(self.heartCrate2)
//        heartCrate2.position = CGPoint(x: -2200, y: -2200)
//        heartCrate2.turnToHeartCrate()
        
        if let audioAction = AudioManager.AudioAction(of: AudioName.GameStart) {
            self.run(audioAction)
        }
    }
    
    override func didSimulatePhysics() {
        var cameraYPos = self.screenCenterY
        self.cam.yScale = 1
        self.cam.xScale = 1
        
        if (player.position.y > screenCenterY) {
            cameraYPos = player.position.y
            let percentOfMaxHeight = (player.position.y - screenCenterY) / (player.MaxHeight() - screenCenterY)
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
//            heartCrate2.reset()
//            heartCrate2.position = CGPoint(x: nextEncounterSpawnPosition - 800, y: 400)
        }
        
        for background in self.backgrounds {
            background.updatePosition(playerProgress: playerProgress)
        }
    }
    
    var lastUpdateTime: TimeInterval = 0
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTime
        let currentFPS = 1 / deltaTime
//        print(currentFPS)
        lastUpdateTime = currentTime
        
        player.update()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let camera = self.camera {
            for touch in touches {
                let absLocation = touch.location(in: self)
                let nodeTouched = atPoint(absLocation)
                //            if let gameSprite = nodeTouched as? GameSprite {
                //                gameSprite.onTap()
                //            }
                self.hud.HandleTapEvent(nodeName: nodeTouched.name)
                
                let relLocation = touch.location(in: camera)
                if (relLocation.x > 0) {
                    // Flap
                    self.player.startFlapping()
                } else {
                    // Turbo
                    self.player.IncreaseVelocity()
                    //self.player.stopFlapping()
                    
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
            hud.setHealthDisplay(newHealth: player.Health())
        case PhysicsCategory.enemy.rawValue:
            self.player.takeDamage()
            hud.setHealthDisplay(newHealth: player.Health())
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
        if GKLocalPlayer.local.isAuthenticated {
            let score = GKScore(leaderboardIdentifier: GameScene.KEY_LEADERBOARD_ID)
            score.value = Int64(self.coinsCollected)
            GKScore.report([score], withCompletionHandler: { (error: Error?) -> Void in
                if error != nil {
                    print(error!)
                }
            })
        }
    }
    
    func checkForAchievements() {
        if GKLocalPlayer.local.isAuthenticated {
            if self.coinsCollected >= 100 {
                let achieve = GKAchievement(identifier: GameScene.KEY_CHALLENGE_100_COINS)
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

extension GameScene: HUDDelegate {
    func RestartGame() {
        self.view?.presentScene(GameScene(size: self.size), transition: .crossFade(withDuration: 0.6))
    }
    
    func MainMenu() {
        self.view?.presentScene(MenuScene(size: self.size), transition: .crossFade(withDuration: 0.6))
    }
    
    
}
