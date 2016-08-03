//
//  Spell.swift
//  Redead
//
//  Created by Matthew Genova on 8/1/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import SpriteKit

class Spell: Weapon{
    let duration = 1.0
    var timer = 0.0
    var directionVector = CGVector(dx: 0,dy: 0)
    let moveSpeed: CGFloat = 200.0
    var spellTextures = [SKTexture]()
    let weaponSize = CGSize(width: 20.0,height: 20.0)
    
    init() {
        spellTextures.append(SKTexture(imageNamed: "Assets/bullet1.png"))
        spellTextures.append(SKTexture(imageNamed: "Assets/bullet2.png"))
        spellTextures.append(SKTexture(imageNamed: "Assets/bullet3.png"))
        spellTextures.append(SKTexture(imageNamed: "Assets/bullet4.png"))
        spellTextures.append(SKTexture(imageNamed: "Assets/bullet5.png"))
        spellTextures.append(SKTexture(imageNamed: "Assets/bullet6.png"))
        spellTextures.append(SKTexture(imageNamed: "Assets/bullet7.png"))
        spellTextures.append(SKTexture(imageNamed: "Assets/bullet8.png"))
        
        super.init(theTexture: spellTextures[0], size: weaponSize)
        
        
        self.physicsSize = weaponSize
        self.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        self.zPosition = 0.1
        hidden = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func attack(direction: DirectionalPad.Direction) {
        setUpPhysics()
        timer = 0.0
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(spellTextures, timePerFrame: 0.1, resize: true, restore: false)), withKey: "attackAnimation")
        attacking = true
        hidden = false
        switch direction {
        case .Down:
            directionVector = CGVector(dx: 0, dy: -1)
        case .Up:
            directionVector = CGVector(dx: 0, dy: 1)
        default:
            directionVector = CGVector(dx: 1, dy: 0)
        }
        
    }
    
    override func onEnemyHit() {
        attacking = false
        hidden = true
        removePhysics()
        self.removeActionForKey("attackAnimation")
    }
    
    override func update(delta: CFTimeInterval){
        if attacking{
            if timer < duration{
                position.x += directionVector.dx * moveSpeed * CGFloat(delta)
                position.y += directionVector.dy * moveSpeed * CGFloat(delta)
                timer += delta
            }else{
                attacking = false
                hidden = true
                removePhysics()
                self.removeActionForKey("attackAnimation")
                
            }

        }
    }
    
}