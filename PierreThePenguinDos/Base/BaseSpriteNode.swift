import Foundation
import SpriteKit

/**
 Base class that extends SKSpriteNode and the BaseNode protocol
 - author: Wacko
 - date: 03/30/2019
 */
class BaseSpriteNode: SKSpriteNode, BaseNode {
    var onTouch: (() -> ())?
    
    func NodeTouched() {
        if let onTouch = self.onTouch {
            onTouch()
        }
    }
}
