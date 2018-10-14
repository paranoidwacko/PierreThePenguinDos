//
//  PhysicsCategory.swift
//  PierreThePenguinDos
//
//  Created by Sparrow on 10/13/18.
//  Copyright © 2018 ParanoidWacko. All rights reserved.
//

import Foundation

enum PhysicsCategory: UInt32 {
    case penguin = 1
    case damagedPenguin = 2
    case ground = 4
    case enemy = 8
    case coin = 16
    case powerup = 32
    case crate = 64
}
