import Foundation
import SpriteKit

/**
 Extension to the SKLabelNode class
 - author: Wacko
 - date: 03/30/2019
 */
extension SKLabelNode {
    convenience init(fontNamed: String?, text: String? = nil, position: CGPoint? = nil, fontSize: CGFloat? = nil, name: String? = nil, verticalAlignmentMode: SKLabelVerticalAlignmentMode? = nil, zPosition: CGFloat? = nil) {
        self.init(fontNamed: fontNamed)
        self.text = text
        if let position = position {
            self.position = position
        }
        if let fontSize = fontSize {
            self.fontSize = fontSize
        }
        self.name = name
        if let verticalAlignmentMode = verticalAlignmentMode {
            self.verticalAlignmentMode = verticalAlignmentMode
        }
        if let zPosition = zPosition {
            self.zPosition = zPosition
        }
    }
}
