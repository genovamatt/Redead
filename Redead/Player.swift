//
//  Player.swift
//  Redead
//
//  Created by Jack Robards on 7/23/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//
import SpriteKit

class Player: SKSpriteNode{
    let playerSize = CGSize(width: 50, height: 65)
    var health = 3
    var directionFacing = DirectionalPad.Direction.Down
    var moveSpeed: CGFloat = 100.0
    var sword = Weapon()
    var walkUpTexture = [SKTexture]()
    var walkDownTexture = [SKTexture]()
    var walkRightTexture = [SKTexture]()
    var upperBound: CGFloat = 0.0
    var lowerBound: CGFloat = 0.0
    var rightBound: CGFloat = 0.0
    var leftBound: CGFloat = 0.0

    init() {
        walkRightTexture.append(SKTexture(imageNamed: "Assets/player_01.png"))
        walkRightTexture.append(SKTexture(imageNamed: "Assets/player_02.png"))
        walkRightTexture.append(SKTexture(imageNamed: "Assets/player_03.png"))
        
        walkDownTexture.append(SKTexture(imageNamed: "Assets/player_04.png"))
        walkDownTexture.append(SKTexture(imageNamed: "Assets/player_05.png"))
        walkDownTexture.append(SKTexture(imageNamed: "Assets/player_06.png"))

        walkUpTexture.append(SKTexture(imageNamed: "Assets/player_07.png"))
        walkUpTexture.append(SKTexture(imageNamed: "Assets/player_08.png"))
        walkUpTexture.append(SKTexture(imageNamed: "Assets/player_09.png"))

        
        //let texture = SKTexture(imageNamed: "Assets/player_05.png")
        super.init(texture: walkDownTexture[1], color: UIColor.clearColor(), size: playerSize)
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
        rightBound = self.position.x + self.size.width/2
        leftBound = self.position.x - self.size.width/2
    }
    
    func update(delta: CFTimeInterval){
        
        let direction = InputManager.instance.getDpadDirection()
        let directionVector = InputManager.instance.getDpadDirectionVector()
        
        if !sword.attacking {
            if direction != .None{
                //xScale = directionVector.dx
                
                
                var x: CGFloat = directionVector.dx * moveSpeed * CGFloat(delta)
                var y: CGFloat = directionVector.dy * moveSpeed * CGFloat(delta)
                
                //Checks the map bounds
                if let tileMap = TileManager.instance.tileMap {
                    let layer = tileMap.layerNamed("MovableMap")
                    var gidTopRightX: Int32
                    var gidTopLeftX: Int32
                    var gidBottomRightX: Int32
                    var gidBottomLeftX: Int32
                    var gidTopRightY: Int32
                    var gidTopLeftY: Int32
                    var gidBottomRightY: Int32
                    var gidBottomLeftY: Int32
                    
                    
                    //Checks the player bounds
                    gidTopRightX = layer.tileGidAt(CGPointMake(rightBound + x, upperBound))
                    gidTopLeftX = layer.tileGidAt(CGPointMake(leftBound + x, upperBound))
                    gidBottomRightX = layer.tileGidAt(CGPointMake(rightBound + x, lowerBound))
                    gidBottomLeftX = layer.tileGidAt(CGPointMake(leftBound + x, lowerBound))
                    gidTopRightY = layer.tileGidAt(CGPointMake(rightBound, upperBound + y))
                    gidTopLeftY = layer.tileGidAt(CGPointMake(leftBound, upperBound + y))
                    gidBottomRightY = layer.tileGidAt(CGPointMake(rightBound, lowerBound + y))
                    gidBottomLeftY = layer.tileGidAt(CGPointMake(leftBound, lowerBound + y))
                    
                    
                    //Checks if the tile the player is moving to is part of the movableMap
                    if gidTopRightX == 0 || gidTopLeftX == 0 || gidBottomLeftX == 0 || gidBottomRightX == 0 {
                        x = 0.0
                    }
                    if gidTopRightY == 0 || gidTopLeftY == 0 || gidBottomLeftY == 0 || gidBottomRightY == 0 {
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
