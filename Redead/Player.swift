//
//  Player.swift
//  Redead
//
//  Created by Jack Robards on 7/23/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//
import SpriteKit

class Player: SKSpriteNode{
    var playerSize = CGSize()
    var health = 3
    var directionFacing = DirectionalPad.Direction.Down
    var previousDirectionalInput = DirectionalPad.Direction.None
    var heartsArray: [SKSpriteNode] = [SKSpriteNode]()
    var moveSpeed: CGFloat = 100.0
    var sword = Weapon()
    var walkUpTexture = [SKTexture]()
    var walkDownTexture = [SKTexture]()
    var walkRightTexture = [SKTexture]()
    let animationFrameTime = 0.1
    var upperBound: CGFloat = 0.0
    var lowerBound: CGFloat = 0.0
    var rightBound: CGFloat = 0.0
    var leftBound: CGFloat = 0.0

    init() {
        walkRightTexture.append(SKTexture(imageNamed: "Assets/player_01_large.png"))
        walkRightTexture.append(SKTexture(imageNamed: "Assets/player_02_large.png"))
        walkRightTexture.append(SKTexture(imageNamed: "Assets/player_03_large.png"))
        walkRightTexture.append(SKTexture(imageNamed: "Assets/player_02_large.png"))
        
        walkDownTexture.append(SKTexture(imageNamed: "Assets/player_04_large.png"))
        walkDownTexture.append(SKTexture(imageNamed: "Assets/player_05_large.png"))
        walkDownTexture.append(SKTexture(imageNamed: "Assets/player_06_large.png"))
        walkDownTexture.append(SKTexture(imageNamed: "Assets/player_05_large.png"))

        walkUpTexture.append(SKTexture(imageNamed: "Assets/player_07_large.png"))
        walkUpTexture.append(SKTexture(imageNamed: "Assets/player_08_large.png"))
        walkUpTexture.append(SKTexture(imageNamed: "Assets/player_09_large.png"))
        walkUpTexture.append(SKTexture(imageNamed: "Assets/player_08_large.png"))
        
        heartsArray.append(SKSpriteNode(imageNamed: "Assets/heart.png"))
        heartsArray.append(SKSpriteNode(imageNamed: "Assets/heart.png"))
        heartsArray.append(SKSpriteNode(imageNamed: "Assets/heart.png"))

        playerSize = walkDownTexture[1].size()
        //let texture = SKTexture(imageNamed: "Assets/player_05.png")
        super.init(texture: walkDownTexture[1], color: UIColor.clearColor(), size: walkDownTexture[1].size())
        sword.position = self.position
        self.addChild(sword)
        
        upperBound = self.position.y + playerSize.height/3
        lowerBound = self.position.y - playerSize.height/2
        rightBound = self.position.x + playerSize.width/3
        leftBound = self.position.x - playerSize.width/3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func move(xMove: CGFloat, yMove: CGFloat) {
        self.position.x += xMove
        self.position.y += yMove
        upperBound = self.position.y + playerSize.height/3
        lowerBound = self.position.y - playerSize.height/2
        rightBound = self.position.x + playerSize.width/3
        leftBound = self.position.x - playerSize.width/3
    }
    
    func update(delta: CFTimeInterval){
        
        let direction = InputManager.instance.getDpadDirection()
        let directionVector = InputManager.instance.getDpadDirectionVector()
        
        if !sword.attacking && direction != .None{
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
            
            if previousDirectionalInput != direction{
                if direction == .Right{
                    xScale = 1
                    self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkRightTexture, timePerFrame: animationFrameTime, resize: true, restore: false)), withKey: "moveAnimation")
                }
                else if direction == .Left{
                    xScale = -1
                    self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkRightTexture, timePerFrame: animationFrameTime,resize: true, restore: false)), withKey: "moveAnimation")
                }
                else if direction == .Up{
                    self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkUpTexture, timePerFrame: animationFrameTime,resize: true, restore: false)), withKey: "moveAnimation")
                }
                else if direction == .Down{
                    self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkDownTexture, timePerFrame: animationFrameTime,resize: true, restore: false)), withKey: "moveAnimation")
                }
            }
            
            previousDirectionalInput = direction
            
        }else{
            self.removeActionForKey("moveAnimation")
            previousDirectionalInput = .None
        }
        
        if InputManager.instance.xButtonPressedInFrame{
            print("x")
            attack()
        }
        
        
    }
    
    func attack(){
        if !sword.attacking{
            switch directionFacing {
            case .Down: sword.position = CGPointMake(0, -playerSize.height/3)
            case .Left: sword.position = CGPointMake(playerSize.width/3, 0)
            case .Right: sword.position = CGPointMake(playerSize.width/3, 0)
            case .Up: sword.position = CGPointMake(0, playerSize.height/3)
            default: break
            }
            sword.attack(directionFacing)
        }
    }
    
    func takeDamage() {
        if (health > 0) {
            heartsArray[health-1].texture = SKTexture(imageNamed: "Assets/empty_heart.png")
            health -= 1
        }
        
    }
    
    
    
    
    
}
