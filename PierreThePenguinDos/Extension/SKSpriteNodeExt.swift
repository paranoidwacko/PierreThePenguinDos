import Foundation
import SpriteKit

/**
 Extension for the Sprite Node class
 - author: Wacko
 - date: 03/30/2019
 */
extension SKSpriteNode {
    public convenience init(name: String? = nil, position: CGPoint? = nil, size: CGSize? = nil, texture: SKTexture?, zPosition: CGFloat? = nil) {
        self.init()
        
        self.name = name
        if let position = position {
            self.position = position
        }
        if let size = size {
            self.size = size
        }
        self.texture = texture
        if let zPosition = zPosition {
            self.zPosition = zPosition
        }
    }
    
    public convenience init(imageNamed: String, size: CGSize? = nil, zPosition: CGFloat? = nil) {
        self.init(imageNamed: imageNamed)
        if let size = size {
            self.size = size
        }
        if let zPosition = zPosition {
            self.zPosition = zPosition
        }
    }
}
