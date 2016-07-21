//
//  DirectionalPad.swift
//  Redead
//
//  Created by Matthew Genova on 7/20/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import SpriteKit

class DirectionalPad: SKSpriteNode{
    enum Direction {
        case None, Up, Down, Left, Right
    }
    
    
    init(imageName: String, size: CGSize) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    

    
}
