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
    
    init(imageName: String, size: CGSize) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: size)
        sword.position = self.position
        self.addChild(sword)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(xMove: CGFloat, yMove: CGFloat) {
        self.position.x += xMove
        self.position.y += yMove
    }
    
    func update(delta: CFTimeInterval){
        
        let direction = InputManager.instance.getDpadDirection()
        let directionVector = InputManager.instance.getDpadDirectionVector()
        
        if !sword.attacking{
            if direction != .None{
                var x: CGFloat = directionVector.dx * moveSpeed * CGFloat(delta)
                var y: CGFloat = directionVector.dy * moveSpeed * CGFloat(delta)
                
                //Checks the map bounds
                if let tileMap = TileManager.instance.tileMap{
                    if !tileMap.layerNamed("MapArea").containsPoint(CGPointMake(position.x + x, position.y)) {
                        x = 0.0
                    }
                    if !tileMap.layerNamed("MapArea").containsPoint(CGPointMake(position.x, position.y + y)) {
                        y = 0.0
                    }
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
