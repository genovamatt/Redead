//
//  GameScene.swift
//  Redead
//
//  Created by Matthew Genova on 7/18/16.
//  Copyright (c) 2016 Matthew Genova. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    var directionalPad:DirectionalPad? = nil
    var player:Player? = nil
    var tileMap:JSTileMap? = nil
    var lastInterval: CFTimeInterval?
    private let screenWidth = ScreenHelper.instance.visibleScreen.width
    private let screenHeight = ScreenHelper.instance.visibleScreen.height
    private let originX = ScreenHelper.instance.visibleScreen.origin.x
    private let originY = ScreenHelper.instance.visibleScreen.origin.y
    
    override func didMoveToView(view: SKView) {
        addButtonsToScene()
        addPlayerToScene()
        addMapToScene()
    }
    
    func addButtonsToScene(){
        let buttonSize = CGSize(width: screenWidth/10, height: screenWidth/10)
        let zButton = SgButton(normalImageNamed: "Assets/blueButton.png", highlightedImageNamed: "Assets/bluePushed.png", buttonFunc: pushedZButton)
        zButton.size = buttonSize
        zButton.position = CGPointMake(originX + screenWidth * 16/20.0, originY + screenHeight * 4/16.0)
        
        let xButton = SgButton(normalImageNamed: "Assets/redButton.png", highlightedImageNamed: "Assets/redPushed.png", buttonFunc: pushedXButton)
        xButton.size = buttonSize
        xButton.position = CGPointMake(originX + screenWidth * 18/20.0, originY + screenHeight * 2/16.0)
        
        self.addChild(zButton)
        self.addChild(xButton)
        
        let dPadSize = CGSize(width: screenWidth/5, height: screenWidth/5)

        directionalPad = DirectionalPad(imageName: "Assets/flatDark00.png", size: dPadSize)
        
        directionalPad!.position = CGPointMake(originX + screenWidth * 1/8.0, originY + screenHeight * 5/22.0)
        self.addChild(directionalPad!)
    }
    
    func addMapToScene() {
        tileMap = JSTileMap(named: "XMLSampleLayers.tmx")
        tileMap!.position = CGPoint(x: originX + screenWidth/4, y: originY + screenHeight/12)
        
        //Made it so the player is a child of the map, not the scene
        tileMap!.addChild(player!)
        
        self.addChild(tileMap!)
    }
    
    func addPlayerToScene() {
        player = Player(imageName: "Assets/Placeholder_Character.png", size: CGSizeMake(originX + screenHeight/20, originX + screenHeight/20))
        player!.position = CGPointMake(10.0, 10.0)
    }
    
    func pushedXButton(button: SgButton){
        print("x button")
    }
    
    func pushedZButton(button: SgButton){
        print("z button")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        //Controls the players movement
        
        if lastInterval == nil {
            lastInterval = currentTime
        }
        
        var delta: CFTimeInterval = currentTime - lastInterval!
        
        if (delta > 0.02) {
            delta = 0.02;
        }
        
        lastInterval = currentTime
        
        if directionalPad!.direction != .None{
            var x: CGFloat = 0.0
            var y: CGFloat = 0.0
            let moveUpOrRight: CGFloat = 50
            let moveDownOrLeft: CGFloat = -moveUpOrRight
            let moveDiagnolRightOrUp: CGFloat = 33.3
            let moveDiagnolLeftOrDown: CGFloat = -moveDiagnolRightOrUp
            
            if directionalPad!.direction == .Up {
                y = moveUpOrRight
            }
            else if directionalPad!.direction == .UpLeft  {
                x = moveDiagnolLeftOrDown
                y = moveDiagnolRightOrUp
            }
            else if directionalPad!.direction == .UpRight  {
                x = moveDiagnolRightOrUp
                y = moveDiagnolRightOrUp
            }
            else if directionalPad!.direction == .Left  {
                x = moveDownOrLeft
            }
            else if directionalPad!.direction == .Right {
                x = moveUpOrRight
            }
            else if directionalPad!.direction == .DownRight  {
                x = moveDiagnolRightOrUp
                y = moveDiagnolLeftOrDown
            }
            else if directionalPad!.direction == .DownLeft  {
                x = moveDiagnolLeftOrDown
                y = moveDiagnolLeftOrDown
            }
            else if directionalPad!.direction == .Down  {
                y = moveDownOrLeft
            }
            
            //Checks the map bounds
            if !tileMap!.layerNamed("Tile Layer 1").containsPoint(CGPointMake(player!.position.x + x, player!.position.y)) {
                x = 0.0            }
            if !tileMap!.layerNamed("Tile Layer 1").containsPoint(CGPointMake(player!.position.x, player!.position.y + y)) {
                y = 0.0
            }

            player!.move(x * CGFloat(delta), yMove: y * CGFloat(delta))
        }
        
        
        /* Can use this sort of setup to determine what layer the player is currently a part of
        if (tileMap!.layerNamed("Tile Layer 4").containsPoint(player!.position)) {
            print("Death")
        }
        else {
            print("Life")
        }*/
    }
    
    
    }
