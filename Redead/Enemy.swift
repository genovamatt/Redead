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
    let animationFrameTime = 0.2
    var dead = false
    
    var knockbackTimer = 0.0
    var knockbackDirectionVector = CGVector()
    let knockbackTime = 0.3
    let knockbackSpeed: CGFloat = 150.0
    var isKnockedBack = false
    var hasAppeared = false


    var upperBound: CGFloat = 0.0
    var lowerBound: CGFloat = 0.0
    var leftBound: CGFloat = 0.0
    var rightBound: CGFloat = 0.0
    
    enum Direction {
        case None, UpLeft, UpRight, DownLeft, DownRight, Up, Down, Left, Right
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
        
        let enemySize = CGSizeMake(walkLeftTexture[1].size().width, walkLeftTexture[1].size().height)
        
        
        player = thePlayer
        
        super.init(texture: appearTexture[0], color: UIColor.clearColor(), size: enemySize)
        
        upperBound = self.position.y + self.size.height/2 - 10
        lowerBound = self.position.y - self.size.height/2 + 10
        rightBound = self.position.x + self.size.width/3 - 10
        leftBound = self.position.x - self.size.width/3 + 10
        
        setUpPhysics()

        
        switch level{
        case .Hard:
            moveSpeed = 200.0
        case .Medium:
            moveSpeed = 150.0
        case .Easy:
            moveSpeed = 100.0
        }
    }
    
    func setUpPhysics(){
        let physicsRectSize = CGSize(width: size.width*2/3, height: size.height*2/3)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: physicsRectSize)
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.categoryBitMask = 4
        self.physicsBody!.contactTestBitMask = 1 | 2
    }
    
    func removePhysics(){
        self.physicsBody = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takeDamage(weapon: Weapon) {
        if health > 0 {
            health -= 1
            flash()
            removePhysics()
            
            
            if health == 0 {
                dead = true
                self.removeActionForKey("moveAnimation")
                self.runAction(SKAction.animateWithTextures(deathTexture, timePerFrame: animationFrameTime*1.2, resize: true, restore: false), completion: {self.removeFromParent()})
            }else{
                isKnockedBack = true
                knockbackTimer = knockbackTime
                var direction = CGVector(dx:  position.x - player.position.x, dy: position.y - player.position.y)
                let magnitude = sqrt(direction.dx * direction.dx + direction.dy * direction.dy)
                direction.dx = direction.dx / magnitude
                direction.dy = direction.dy / magnitude
                
                knockbackDirectionVector = direction
            }
        }
        print("Enemy Health: \(health)")
    }
    
    func flash(){
        let turnRedColor = SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1, duration: 0.2)
        let turnNormalColor = SKAction.colorizeWithColor(UIColor.clearColor(), colorBlendFactor: 0, duration: 0.2)
        self.runAction(turnRedColor, completion: {
            self.runAction(turnNormalColor, completion: {
                self.runAction(turnRedColor, completion: {
                    self.runAction(turnNormalColor)
                })
            })
            
        })
    }

    
    func move(xMove: CGFloat, yMove: CGFloat) {
        self.position.x += xMove * moveSpeed / 100.0
        self.position.y += yMove * moveSpeed / 100.0
        upperBound = self.position.y + self.size.height/2 - 10
        lowerBound = self.position.y - self.size.height/2 + 10
        rightBound = self.position.x + self.size.width/3 - 10
        leftBound = self.position.x - self.size.width/3 + 10
    }
    
    func getDirectionVector() -> (CGVector){
        switch directionFacing{
            case .None: return CGVector(dx: 0,dy: 0)
            case .Up: return CGVector(dx: 0, dy: distanceFromPlayer()/200.0)
            case .Down: return CGVector(dx: 0, dy: -distanceFromPlayer()/200.0)
            case .Left: return CGVector(dx: -distanceFromPlayer()/200.0, dy: 0)
            case .Right: return CGVector(dx: distanceFromPlayer()/200.0, dy: 0)
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
        if !dead{
            if isKnockedBack{
                if knockbackTimer > 0{
                    knockbackTimer -= delta
                    let x: CGFloat = knockbackDirectionVector.dx * knockbackSpeed * CGFloat(delta)
                    let y: CGFloat = knockbackDirectionVector.dy * knockbackSpeed * CGFloat(delta)
                    
                    move(x, yMove: y)
                }else{
                    isKnockedBack = false
                    setUpPhysics()
                }
            }
            else{
            
                if !hasAppeared && distanceFromPlayer() <= 400 {
                    self.runAction(SKAction.animateWithTextures(appearTexture, timePerFrame: animationFrameTime, resize: true, restore: false), completion: {
                        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(self.idleTexture, timePerFrame: self.animationFrameTime, resize: true, restore: false)), withKey: "idleAnimation")
                    })
                    hasAppeared = true
                }
                if player.position.x <= self.position.x + 1.5 && player.position.x >= self.position.x - 1.5  && distanceFromPlayer() < 350.0 {
                    if player.position.y > self.position.y {
                        directionFacing = .Up
                    }
                    else {
                        directionFacing = .Down
                    }
                }
                else if player.position.y <= self.position.y + 1.5 && player.position.y >= self.position.y - 1.5 && distanceFromPlayer() < 350.0 {
                    if player.position.x > self.position.x {
                        directionFacing = .Right
                    }
                    else {
                        directionFacing = .Left
                    }
                }
                else if player.position.x <= self.position.x && distanceFromPlayer() < 200.0 && player.position.y > self.position.y {
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
                    if player.position.x == self.position.x {
                        x = 0.0
                        y = 0.0
                    }
                    if player.position.y == self.position.y {
                        x = 0.0
                        y = 0.0
                    }
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
                        }                }
                    
                    move(x , yMove: y)
                    
                    if (previousDirectionalInput == .None) {
                        self.removeActionForKey("idleAnimation")
                    }
                    
                    if previousDirectionalInput != directionFacing {
                        if directionFacing == .UpRight || directionFacing == .DownRight || directionFacing == .Right || directionFacing == .Down {
                            xScale = -1
                            self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkLeftTexture, timePerFrame: animationFrameTime, resize: true, restore: false)), withKey: "moveAnimation")
                        }
                        else if directionFacing == .UpLeft || directionFacing == .DownLeft || directionFacing == .Left || directionFacing == .Up {
                            xScale = 1
                            self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkLeftTexture, timePerFrame: animationFrameTime,resize: true, restore: false)), withKey: "moveAnimation")
                        }
                    }
                    
                    previousDirectionalInput = directionFacing
                }
                else{
                    self.removeActionForKey("moveAnimation")
                    if (previousDirectionalInput != .None) {
                        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(idleTexture, timePerFrame: animationFrameTime, resize: true, restore: false)), withKey: "idleAnimation")
                    }
                    previousDirectionalInput = .None
                    
                }
                

            }
        }
    }
}
