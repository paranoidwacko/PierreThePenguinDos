import Foundation
import SpriteKit

/**
 Base class that extends SKLabelNode and the BaseNode protocol
 - author: Wacko
 - date: 03/30/2019
 */
class BaseLabelNode: SKLabelNode, BaseNode {
    var onTouch: (() -> ())?
    
    func NodeTouched() {
        if let onTouch = self.onTouch {
            onTouch()
        }
    }
}
