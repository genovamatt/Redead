//
//  Enemy.swift
//  Redead
//
//  Created by Matthew Genova on 7/25/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import SpriteKit

enum Difficulty{
    case Hard, Medium, Easy
}

class Enemy: SKSpriteNode{
    var health = 3
    var directionFacing = DirectionalPad.Direction.Down
    var moveSpeed: CGFloat = 100.0
    var upperBound: CGFloat = 0.0
    var lowerBound: CGFloat = 0.0
    var leftBound: CGFloat = 0.0
    var rightBound: CGFloat = 0.0
    
    init(imageName: String, size: CGSize, level: Difficulty) {
        let texture = SKTexture(imageNamed: imageName)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: size)
        
        upperBound = self.position.y + self.size.height/2
        lowerBound = self.position.y - self.size.height/2
        rightBound = self.position.x + self.size.width/3
        leftBound = self.position.x - self.size.width/3
        
        switch level{
        case .Hard:
            moveSpeed = 200.0
        case .Medium:
            moveSpeed = 150.0
        case .Easy:
            moveSpeed = 100.0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(xMove: CGFloat, yMove: CGFloat) {
        self.position.x += xMove * moveSpeed / 100.0
        self.position.y += yMove * moveSpeed / 100.0
        upperBound = self.position.y + self.size.height/2
        lowerBound = self.position.y - self.size.height/2
        rightBound = self.position.x + self.size.width/3
        leftBound = self.position.x - self.size.width/3

        print(upperBound)
    }
    
    func update(delta: CFTimeInterval){
        
        let direction = InputManager.instance.getDpadDirection()
        let directionVector = InputManager.instance.getDpadDirectionVector()
        

        
        if direction != .None{
            var x: CGFloat = directionVector.dx * moveSpeed * CGFloat(delta)
            var y: CGFloat = directionVector.dy * moveSpeed * CGFloat(delta)
                
            //Checks the map bounds
            if let tileMap = TileManager.instance.tileMap {
                let layer = tileMap.layerNamed("MovableMap")
                var gidXRight: Int32
                var gidXLeft: Int32
                var gidYUp: Int32
                var gidYDown: Int32
                    
                    
                //Checks the player bounds
                gidXRight = layer.tileGidAt(CGPointMake(rightBound + x, position.y))
                gidXLeft = layer.tileGidAt(CGPointMake(leftBound + x, position.y))
                gidYUp = layer.tileGidAt(CGPointMake(position.x, upperBound + y))
                gidYDown = layer.tileGidAt(CGPointMake(position.x, lowerBound + y))
                
                //Checks if the tile the player is moving to is part of the movableMap
                if gidXRight == 0 || gidXLeft == 0 {
                    x = 0.0
                }
                if gidYUp == 0 || gidYDown == 0 {
                    y = 0.0
                }
                    
                //This is no longer used, left here for reference
                /*if !tileMap.layerNamed("MovableMap").containsPoint(CGPointMake(position.x + x, position.y)) {
                    x = 0.0
                }
                if !tileMap.layerNamed("MovableMap").containsPoint(CGPointMake(position.x, position.y + y)) {
                    y = 0.0
                }*/
            }
            
            move(x , yMove: y)
            
            directionFacing = direction
        }
    }

}
