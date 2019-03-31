/**
 Generic utilities for animations
 - author: Wacko
 - date: 03/30/2019
 */
import Foundation
import SpriteKit

public func FadeAnimation(fadeTo: CGFloat = 0.5, fadeTime: TimeInterval = 0.9) -> SKAction {
    return SKAction.sequence([
        SKAction.fadeAlpha(to: fadeTo, duration: fadeTime),
        SKAction.fadeAlpha(to: 1, duration: fadeTime)
    ])
}
