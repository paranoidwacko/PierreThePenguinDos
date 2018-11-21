//
//  PhysicsCategory.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/13/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation

enum PhysicsCategory: UInt32 {
    case penguin        = 0b00000001
    case damagedPenguin = 0b00000010
    case ground         = 0b00000100
    case enemy          = 0b00001000
    case coin           = 0b00010000
    case powerup        = 0b00100000
    case crate          = 0b01000000
}
