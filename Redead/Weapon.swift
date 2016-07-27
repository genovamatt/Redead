//
//  Weapon.swift
//  Redead
//
//  Created by Matthew Genova on 7/25/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import SpriteKit

class Weapon: SKSpriteNode{
    let swingTime = 1.0
    var attacking = false
    
    init() {
        let texture = SKTexture(imageNamed: "Assets/sword.png")
        let size = CGSize(width: 50, height: 10)
        super.init(texture: texture, color: UIColor.clearColor(), size: size)
        hidden = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(delta: CFTimeInterval){
        
    }
    
    func attack(direction: DirectionalPad.Direction){
        
    }
    
}
