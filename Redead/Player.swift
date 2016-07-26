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
    var directionalPad: DirectionalPad? = nil
    var moveSpeed: CGFloat = 100.0
    
    init(imageName: String, size: CGSize, directionalPad: DirectionalPad) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: size)
        self.directionalPad = directionalPad
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(xMove: CGFloat, yMove: CGFloat) {
        self.position.x += xMove
        self.position.y += yMove
    }
    
    
    
    
    func update(delta: CFTimeInterval){
        if directionalPad!.direction != .None{
            var x: CGFloat = directionalPad!.getDirectionVector().dx * moveSpeed * CGFloat(delta)
            var y: CGFloat = directionalPad!.getDirectionVector().dy * moveSpeed * CGFloat(delta)
            
            //Checks the map bounds
            if let tileMap = TileManager.instance.tileMap{
                if !tileMap.layerNamed("MapArea").containsPoint(CGPointMake(position.x + x, position.y)) {
                    x = 0.0            }
                if !tileMap.layerNamed("MapArea").containsPoint(CGPointMake(position.x, position.y + y)) {
                    y = 0.0
                }
                
                
            }
            
            move(x , yMove: y)
            
            
        }
    }
    
    
    
    
    
}
