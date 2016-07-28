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
        
        if !sword.attacking {
            if direction != .None{
                //xScale = directionVector.dx
                
                
                var x: CGFloat = directionVector.dx * moveSpeed * CGFloat(delta)
                var y: CGFloat = directionVector.dy * moveSpeed * CGFloat(delta)
                
                //Checks the map bounds
                if let tileMap = TileManager.instance.tileMap{
                    if !tileMap.layerNamed("MovableMap").containsPoint(CGPointMake(position.x + x, position.y)) {
                        x = 0.0
                    }
                    if !tileMap.layerNamed("MovableMap").containsPoint(CGPointMake(position.x, position.y + y)) {
                        y = 0.0
                    }
                    //Look into doing this using Gid and zposition perhaps

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
