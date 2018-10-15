//
//  TextureManager.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/14/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation
import SpriteKit

class TextureManager {
    fileprivate static let pInstance = TextureManager()
    fileprivate var textures: [TextureName: SKTexture]
    
    fileprivate init() {
        self.textures = [TextureName: SKTexture]()
        self.initializeTextures()
    }
    
    public static func Texture(textureName: TextureName?) -> SKTexture? {
        if let textureName = textureName {
            return pInstance.textures[textureName]
        }
        return nil
    }
    
    fileprivate func initializeTextures() {
        self.initializeTextures(textureAtlas: SKTextureAtlas(named: TextureAtlasName.Enemies.rawValue), textureNames: [
            TextureName.Bat,
            TextureName.BatFly,
            TextureName.Bee,
            TextureName.BeeFly,
            TextureName.Blade,
            TextureName.Blade2,
            TextureName.MadFly,
            TextureName.MadFlyFly
            ])
        self.initializeTextures(textureAtlas: SKTextureAtlas(named: TextureAtlasName.Environment.rawValue), textureNames: [
            TextureName.CoinBronze,
            TextureName.CoinGold,
            TextureName.Crate,
            TextureName.CratePowerUp,
            TextureName.Ground,
            TextureName.Star
            ])
        self.initializeTextures(textureAtlas: SKTextureAtlas(named: TextureAtlasName.Pierre.rawValue), textureNames: [
            TextureName.PierreFlying1,
            TextureName.PierreFlying2,
            TextureName.PierreFlying3,
            TextureName.PierreFlying4,
            TextureName.PierreDead
            ])
        self.initializeTextures(textureAtlas: SKTextureAtlas(named: TextureAtlasName.Background.rawValue), textureNames: [
            TextureName.BackgroundFront,
            TextureName.BackgroundMiddle,
            TextureName.BackgroundBack
            ])
        self.initializeTextures(textureAtlas: SKTextureAtlas(named: TextureAtlasName.HUD.rawValue), textureNames: [
            TextureName.HeartFull,
            TextureName.Button,
            TextureName.ButtonRestart,
            TextureName.ButtonMenu
            ])
    }
    
    fileprivate func initializeTextures(textureAtlas: SKTextureAtlas, textureNames: [TextureName]) {
        for textureName in textureNames {
            self.textures[textureName] = textureAtlas.textureNamed(textureName.rawValue)
        }
    }
}
