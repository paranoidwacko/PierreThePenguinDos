//
//  EncounterManager.swift
//  PierreThePenguinDos
//
//  Created by Joaquin Hidalgo on 10/10/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class EncounterManager {
    let encounterName: [String] = [
        "EncounterA"
    ]
    var encounters: [SKNode] = []
    
    init() {
        for encounterFileName in self.encounterName {
            let encounterNode = SKNode()
            if let encounterScene = SKScene(fileNamed: encounterFileName) {
                for child in encounterScene.children {
                    let copyOfNode = type(of: child).init()
                    copyOfNode.position = child.position
                    copyOfNode.name = child.name
                    encounterNode.addChild(copyOfNode)
                }
            }
            self.encounters.append(encounterNode)
        }
    }
    
    func addEncountersToScene(gameScene: SKNode) {
        var encounterPosY = 1000
        for encounterNode in encounters {
            encounterNode.position = CGPoint(x: -2000, y: encounterPosY)
            gameScene.addChild(encounterNode)
            encounterPosY *= 2
        }
    }
}
