//
//  DirectionalPad.swift
//  Redead
//
//  Created by Matthew Genova on 7/20/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import SpriteKit

class DirectionalPad: SKSpriteNode{
    let diagonal = 0.71
    
    enum Direction {
        case None, Up, Down, Left, Right, UpLeft, UpRight, DownLeft, DownRight
    }
    
    struct DirectionZone{
        var direction: Direction
        var zone: CGRect
    }
    
    var direction = Direction.None
    var zones = [DirectionZone]()
    
    
    init(imageName: String, size: CGSize) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: size)
        
        setUpZones()
        userInteractionEnabled = true
    }
    
    func getDirectionVector() -> (CGVector){
        switch direction{
        case .None: return CGVector(dx: 0,dy: 0)
        case .Up: return CGVector(dx: 0,dy: 1)
        case .Down: return CGVector(dx: 0, dy: -1)
        case .Left: return CGVector(dx: -1, dy: 0)
        case .Right: return CGVector(dx: 1, dy: 0)
        case .UpLeft: return CGVector(dx: -diagonal, dy: diagonal)
        case .UpRight: return CGVector(dx: diagonal, dy: diagonal)
        case .DownLeft: return CGVector(dx: -diagonal, dy: -diagonal)
        case .DownRight: return CGVector(dx: diagonal, dy: -diagonal)
        }
    }
    
    private func setUpZones(){
        let zoneSize = CGSize(width: size.width/3.0, height: size.height/3.0)
        
        var zoneOrigin = CGPointMake(-zoneSize.width * 1.5, zoneSize.height * 0.5)
        zones.append(DirectionZone(direction: .UpLeft, zone: CGRect(origin: zoneOrigin, size: zoneSize)))
        
        zoneOrigin = CGPointMake(-zoneSize.width * 0.5, zoneSize.height * 0.5)
        zones.append(DirectionZone(direction: .Up, zone: CGRect(origin: zoneOrigin, size: zoneSize)))
        
        zoneOrigin = CGPointMake(zoneSize.width * 0.5 , zoneSize.height * 0.5)
        zones.append(DirectionZone(direction: .UpRight, zone: CGRect(origin: zoneOrigin, size: zoneSize)))
        
        zoneOrigin = CGPointMake(-zoneSize.width * 1.5, -zoneSize.height * 0.5)
        zones.append(DirectionZone(direction: .Left, zone: CGRect(origin: zoneOrigin, size: zoneSize)))
        
        zoneOrigin = CGPointMake(-zoneSize.width * 0.5, -zoneSize.height * 0.5)
        zones.append(DirectionZone(direction: .None, zone: CGRect(origin: zoneOrigin, size: zoneSize)))
        
        zoneOrigin = CGPointMake(zoneSize.width * 0.5, -zoneSize.height * 0.5)
        zones.append(DirectionZone(direction: .Right, zone: CGRect(origin: zoneOrigin, size: zoneSize)))
        
        zoneOrigin = CGPointMake(-zoneSize.width * 1.5, -zoneSize.height * 1.5)
        zones.append(DirectionZone(direction: .DownLeft, zone: CGRect(origin: zoneOrigin, size: zoneSize)))
        
        zoneOrigin = CGPointMake(-zoneSize.width * 0.5, -zoneSize.height * 1.5)
        zones.append(DirectionZone(direction: .Down, zone: CGRect(origin: zoneOrigin, size: zoneSize)))
        
        zoneOrigin = CGPointMake(zoneSize.width * 0.5, -zoneSize.height * 1.5)
        zones.append(DirectionZone(direction: .DownRight, zone: CGRect(origin: zoneOrigin, size: zoneSize)))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            let location = touch.locationInNode(self)
            
            direction = .None
            for z in zones{
                if z.zone.contains(location){
                    direction = z.direction
                    break
                }
            }
        }

    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            let location = touch.locationInNode(self)
            
            direction = .None
            for z in zones{
                if z.zone.contains(location){
                    direction = z.direction
                    break
                }
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
       direction = .None
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        direction = .None
    }

    
}
