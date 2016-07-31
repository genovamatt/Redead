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
    var directionFacing = Direction.None
    var previousDirectionalInput = Direction.None
    var moveSpeed: CGFloat = 100.0
    var walkLeftTexture = [SKTexture]()
    var attackTexture = [SKTexture]()
    var appearTexture = [SKTexture]()
    var idleTexture = [SKTexture]()
    var deathTexture = [SKTexture]()
    let player: Player
    let animationFrameTime = 0.1

    var upperBound: CGFloat = 0.0
    var lowerBound: CGFloat = 0.0
    var leftBound: CGFloat = 0.0
    var rightBound: CGFloat = 0.0
    
    enum Direction {
        case None, UpLeft, UpRight, DownLeft, DownRight
    }
    
    init(level: Difficulty, thePlayer: Player) {
        walkLeftTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/walk/go_1.png"))
        walkLeftTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/walk/go_2.png"))
        walkLeftTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/walk/go_3.png"))
        walkLeftTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/walk/go_4.png"))
        walkLeftTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/walk/go_5.png"))
        walkLeftTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/walk/go_6.png"))
        walkLeftTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/walk/go_7.png"))
        
        attackTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/attack/hit_1.png"))
        attackTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/attack/hit_2.png"))
        attackTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/attack/hit_3.png"))
        attackTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/attack/hit_4.png"))
        attackTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/attack/hit_5.png"))
        attackTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/attack/hit_6.png"))
        attackTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/attack/hit_7.png"))
        
        appearTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/appear/appear_1.png"))
        appearTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/appear/appear_2.png"))
        appearTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/appear/appear_3.png"))
        appearTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/appear/appear_4.png"))
        appearTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/appear/appear_5.png"))
        appearTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/appear/appear_6.png"))
        appearTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/appear/appear_7.png"))
        appearTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/appear/appear_8.png"))
        appearTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/appear/appear_9.png"))
        appearTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/appear/appear_10.png"))
        appearTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/appear/appear_11.png"))
        
        deathTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/die/die_1.png"))
        deathTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/die/die_2.png"))
        deathTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/die/die_3.png"))
        deathTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/die/die_4.png"))
        deathTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/die/die_5.png"))
        deathTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/die/die_6.png"))
        deathTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/die/die_7.png"))
        deathTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/die/die_8.png"))
        
        idleTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/idle/idle_1.png"))
        idleTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/idle/idle_2.png"))
        idleTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/idle/idle_3.png"))
        idleTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/idle/idle_4.png"))
        idleTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/idle/idle_5.png"))
        idleTexture.append(SKTexture(imageNamed: "Assets/CuteZombieSprite/idle/idle_6.png"))
        
        let enemySize = CGSizeMake(walkLeftTexture[1].size().width/2.5, walkLeftTexture[1].size().height/2.5)
        
        
        player = thePlayer
        
        super.init(texture: idleTexture[0], color: UIColor.clearColor(), size: enemySize)
        
        upperBound = self.position.y + self.size.height/2
        lowerBound = self.position.y - self.size.height/2
        rightBound = self.position.x + self.size.width/3
        leftBound = self.position.x - self.size.width/3
        
        let physicsRectSize = CGSize(width: size.width*2/3, height: size.height*2/3)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: physicsRectSize)
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.categoryBitMask = 4
        self.physicsBody!.contactTestBitMask = 1 | 2
        
        
        
        switch level{
        case .Hard:
            moveSpeed = 200.0
        case .Medium:
            moveSpeed = 150.0
        case .Easy:
            moveSpeed = 100.0
        }
        
        self.runAction(SKAction.animateWithTextures(appearTexture, timePerFrame: animationFrameTime, resize: true, restore: false))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takeDamage() {
        if health > 0 {
            health -= 1
            if health == 0 {
                print("WHY WON'T YOU DIE")
                self.runAction(SKAction.animateWithTextures(deathTexture, timePerFrame: animationFrameTime, resize: true, restore: false))
                self.removeFromParent()
            }
        }
        print("Health: \(health)")
    }
    
    func move(xMove: CGFloat, yMove: CGFloat) {
        self.position.x += xMove * moveSpeed / 100.0
        self.position.y += yMove * moveSpeed / 100.0
        upperBound = self.position.y + self.size.height/2
        lowerBound = self.position.y - self.size.height/2
        rightBound = self.position.x + self.size.width/3
        leftBound = self.position.x - self.size.width/3
    }
    
    func getDirectionVector() -> (CGVector){
        switch directionFacing{
            case .None: return CGVector(dx: 0,dy: 0)
            case .UpRight: return CGVector(dx: distanceFromPlayer()/200.0,dy: distanceFromPlayer()/200)
            case .DownLeft: return CGVector(dx: -distanceFromPlayer()/200.0, dy: -distanceFromPlayer()/200)
            case .UpLeft: return CGVector(dx: -distanceFromPlayer()/200.0, dy: distanceFromPlayer()/200.0)
            case .DownRight: return CGVector(dx: distanceFromPlayer()/200.0, dy: -distanceFromPlayer()/200.0)
        }
    }
    
    func attack() {
        self.runAction(SKAction.animateWithTextures(attackTexture, timePerFrame: animationFrameTime, resize: true, restore: false))
    }
    
    func distanceFromPlayer() -> CGFloat  {
        return sqrt(pow(player.position.x - self.position.x, 2) + pow(player.position.y - self.position.y, 2))
    }
    
    func update(delta: CFTimeInterval) {
        if player.position.x <= self.position.x && distanceFromPlayer() < 200.0 && player.position.y > self.position.y {
            directionFacing = .UpLeft
        }
        else if player.position.x <= self.position.x && distanceFromPlayer() < 200.0 && player.position.y <= self.position.y {
            directionFacing = .DownLeft
        }
        else if player.position.x > self.position.x && distanceFromPlayer() < 200.0 && player.position.y > self.position.y {
            directionFacing = .UpRight
        }
        else if player.position.x > self.position.x && distanceFromPlayer() < 200.0 && player.position.y <= self.position.y {
            directionFacing = .DownRight
        }
        else {
            directionFacing = .None
        }
        let directionVector = getDirectionVector()
    
        
        if directionFacing != .None{
            var x: CGFloat = directionVector.dx * moveSpeed * CGFloat(delta)
            var y: CGFloat = directionVector.dy * moveSpeed * CGFloat(delta)
            
            //Checks the map bounds
            if let tileMap = TileManager.instance.tileMap {
                let layer = tileMap.layerNamed("MovableMap")
                var gidXRight: Int32
                var gidXLeft: Int32
                var gidYUp: Int32
                var gidYDown: Int32
                    
                    
                //Checks the enemy bounds
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
            
            if previousDirectionalInput != directionFacing {
                if directionFacing == .UpRight || directionFacing == .DownRight{
                    xScale = -1
                    self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkLeftTexture, timePerFrame: animationFrameTime, resize: true, restore: false)), withKey: "moveAnimation")
                }
                else if directionFacing == .UpLeft || directionFacing == .DownLeft {
                    xScale = 1
                    self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkLeftTexture, timePerFrame: animationFrameTime,resize: true, restore: false)), withKey: "moveAnimation")
                }
            }
            
            previousDirectionalInput = directionFacing
        }
        else{
            self.removeActionForKey("moveAnimation")
            previousDirectionalInput = .None
        }
    }

}
