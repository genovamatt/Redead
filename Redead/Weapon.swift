//
//  Weapon.swift
//  Redead
//
//  Created by Matthew Genova on 7/25/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import SpriteKit

class Weapon: SKSpriteNode{
    let totalSwingTime = 1.0
    let swingRotation = 45.0
    var currentSwingTime = 0.0
    var attacking = false
    
    init() {
        let texture = SKTexture(imageNamed: "Assets/sword.png")
        let size = CGSize(width: 100, height: 20)
        super.init(texture: texture, color: UIColor.clearColor(), size: size)
        hidden = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(delta: CFTimeInterval){
        
    }
    
    func attack(direction: DirectionalPad.Direction){
        hidden = false
        attacking = true
        var initialAngle:Float = 0.0
        switch direction{
        case .Up: initialAngle = 90
        case .Down: initialAngle = 90
        case .Left: initialAngle = 90
        case .Right: initialAngle = 90
        case .UpLeft: initialAngle = 90
        case .UpRight: initialAngle = 90
        case .DownLeft: initialAngle = 90
        case .DownRight: initialAngle = 90
        default: initialAngle = 0
        }
        
        self.zRotation = CGFloat(GLKMathDegreesToRadians(initialAngle))
        
        let action = SKAction.rotateByAngle(CGFloat(GLKMathDegreesToRadians(45)), duration: totalSwingTime)
        self.runAction(action, completion: {
            self.attacking = false
            self.hidden = true
        })
    }
    
}
