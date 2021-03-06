//
//  Sword.swift
//  Redead
//
//  Created by Matthew Genova on 8/1/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import Foundation

class Sword: Weapon{
    let totalSwingTime = 0.3
    let swingRotation:Float = 90.0
    let weaponSize = CGSize(width: 70.0,height: 12.0)

    
    init() {
        let texture = SKTexture(imageNamed: "Assets/sword.png")
        super.init(theTexture: texture, size: weaponSize)
        self.physicsSize = CGSize(width: 65.0, height: 10.0)
        self.anchorPoint = CGPoint(x: 0,y: 0.5)
        self.zPosition = 0.1
        hidden = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func attack(direction: DirectionalPad.Direction) {
        setUpPhysics()
        hidden = false
        attacking = true
        var initialAngle:Float = 0.0
        switch direction{
        case .Up: initialAngle = 90
        case .Down: initialAngle = 270
        case .Left: initialAngle = 0 // left and right the same bc scale flips for animation
        case .Right: initialAngle = 0
        case .UpLeft: initialAngle = 135
        case .UpRight: initialAngle = 45
        case .DownLeft: initialAngle = 225
        case .DownRight: initialAngle = 315
        default: initialAngle = 0
        }
        
        initialAngle -= swingRotation/2
        
        self.zRotation = CGFloat(GLKMathDegreesToRadians(initialAngle))
        
        let action = SKAction.rotateByAngle(CGFloat(GLKMathDegreesToRadians(swingRotation)), duration: totalSwingTime)
        self.runAction(action, completion: {
            self.attacking = false
            self.hidden = true
            self.removePhysics()
        })

    }
    
    
    
}