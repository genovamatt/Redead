//
//  Weapon.swift
//  Redead
//
//  Created by Matthew Genova on 7/25/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import SpriteKit

class Weapon: SKSpriteNode{
    let totalSwingTime = 0.5
    let swingRotation:Float = 45.0
    var attacking = false
    
    init() {
        let texture = SKTexture(imageNamed: "Assets/sword.png")
        let size = CGSize(width: 100, height: 20)
        super.init(texture: texture, color: UIColor.clearColor(), size: size)
        
        self.anchorPoint = CGPoint(x: 0,y: 0.5)
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
        case .Down: initialAngle = 270
        case .Left: initialAngle = 180
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
        })
    }
    
}
