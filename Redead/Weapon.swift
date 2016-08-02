//
//  Weapon.swift
//  Redead
//
//  Created by Matthew Genova on 7/25/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import SpriteKit


class Weapon: SKSpriteNode{
    let weaponSize = CGSize(width: 70.0, height: 12.0)
    let totalSwingTime = 0.3
    let swingRotation:Float = 90.0
    var attacking = false
    
    init() {
        let texture = SKTexture(imageNamed: "Assets/sword.png")
        super.init(texture: texture, color: UIColor.clearColor(), size: weaponSize)
        
        self.anchorPoint = CGPoint(x: 0,y: 0.5)
        self.zPosition = 0.1
        hidden = true
        
    }
    
    func setUpPhysics(){
        let physicsRectSize = CGSize(width: weaponSize.width*8/9, height: weaponSize.height*8/9)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: physicsRectSize)
        
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.categoryBitMask = 2
        self.physicsBody!.contactTestBitMask = 4
    }
    
    func removePhysics(){
        self.physicsBody = nil
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func update(delta: CFTimeInterval){
        
    }
    
    func attack(direction: DirectionalPad.Direction){
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
