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
    fileprivate static let ERROR_METHOD_NOT_IMPLEMENTED = NSLocalizedString("method_not_implemented", comment: "")
    
    fileprivate let textureAtlas: SKTextureAtlas?
    fileprivate let initialSize: CGSize?
    
    func onTap() {
        fatalError(GameSprite.ERROR_METHOD_NOT_IMPLEMENTED)
    }
    
    init(textureAtlas: SKTextureAtlas, textureName: TextureName?, color: UIColor, size: CGSize) {
        self.textureAtlas = textureAtlas
        self.initialSize  = size
        if let textureName = textureName, let textureAtlas = self.textureAtlas {
            super.init(texture: textureAtlas.textureNamed(textureName.rawValue), color: color, size: size)
        } else {
            super.init(texture: nil, color: color, size: size)
        }
    }
    
    func Textures(textureNames: [TextureName]) -> [SKTexture] {
        var textures = [SKTexture]()
        if let textureAtlas = self.textureAtlas {
            for name in textureNames {
                textures.append(textureAtlas.textureNamed(name.rawValue))
            }
        }
        return textures
    }
    
    func Texture(textureName: TextureName) {
        if let textureAtlas = self.textureAtlas {
            self.texture = textureAtlas.textureNamed(textureName.rawValue)
        }
    }

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        self.textureAtlas = nil
        self.initialSize = CGSize.zero
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.textureAtlas = nil
        self.initialSize = CGSize.zero
        super.init(coder: aDecoder)
    }
}
