import Foundation
import SpriteKit

/**
 Base Scene to generalize the way I'll handle the tap event
 - author: Wacko
 - date: 03/30/2019
 */
class BaseScene: SKScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let nodeTouched = atPoint(touch.location(in: self)) as? BaseNode {
                nodeTouched.NodeTouched()
            }
        }
    }
}
