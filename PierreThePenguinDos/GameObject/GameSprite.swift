//
//  GameSprite.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/7/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class GameSprite: SKSpriteNode {
    fileprivate static let ERROR_METHOD_NOT_IMPLEMENTED = LocalString(key: "method_not_implemented")

    fileprivate let initialSize: CGSize?
    
    func onTap() {
        fatalError(GameSprite.ERROR_METHOD_NOT_IMPLEMENTED)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        self.initialSize  = size
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.initialSize = CGSize.zero
        super.init(coder: aDecoder)
    }
}
