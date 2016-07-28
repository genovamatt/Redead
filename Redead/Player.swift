//
//  Player.swift
//  Redead
//
//  Created by Jack Robards on 7/23/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//
import SpriteKit

class Player: SKSpriteNode{
    var health = 3
    var directionFacing = DirectionalPad.Direction.Down
    var moveSpeed: CGFloat = 100.0
    var sword = Weapon()
    var upperBound: CGFloat = 0.0
    var lowerBound: CGFloat = 0.0
    var leftBound: CGFloat = 0.0
    var rightBound: CGFloat = 0.0
    
    init(imageName: String, size: CGSize) {
        let texture = SKTexture(imageNamed: imageName)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: size)
        sword.position = self.position
        self.addChild(sword)
        
        upperBound = self.position.y + self.size.height/2
        lowerBound = self.position.y - self.size.height/2
        rightBound = self.position.x + self.size.width/3
        leftBound = self.position.x - self.size.width/3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(xMove: CGFloat, yMove: CGFloat) {
        self.position.x += xMove
        self.position.y += yMove
        upperBound = self.position.y + self.size.height/2
        lowerBound = self.position.y - self.size.height/2
        rightBound = self.position.x + self.size.width/3
        leftBound = self.position.x - self.size.width/3

        print(upperBound)
    }
    
    func update(delta: CFTimeInterval){
        
        let direction = InputManager.instance.getDpadDirection()
        let directionVector = InputManager.instance.getDpadDirectionVector()
        

        
        if !sword.attacking {
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
            
            if InputManager.instance.xButtonPressedInFrame{
                print("x")
                attack()
            }

        }
    }
    
    func attack(){
        if !sword.attacking{
            sword.attack(directionFacing)
        }
    }
    
    
    
    
    
}
