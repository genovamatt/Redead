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
    var heartsArray: [SKSpriteNode] = [SKSpriteNode]()
    var lastInterval: CFTimeInterval?
    var elapsedTime: Float = 0.0
    var timerLabel: SKLabelNode? = nil
    
    private let screenWidth = ScreenHelper.instance.visibleScreen.width
    private let screenHeight = ScreenHelper.instance.visibleScreen.height
    private let originX = ScreenHelper.instance.visibleScreen.origin.x
    private let originY = ScreenHelper.instance.visibleScreen.origin.y
    
    override func didMoveToView(view: SKView) {
        addButtonsToScene()
        addPlayerToScene()
        addMapToScene()
        addHeartsToScene()
        addTimerToScene()
    }
    
    func addTimerToScene(){
        timerLabel = SKLabelNode(text: "00:00")
        timerLabel!.position = CGPointMake(originX + screenWidth * 18/20.0, originY + screenHeight * 18/20.0)
        self.addChild(timerLabel!)
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
    
    func addHeartsToScene() {
        let heartSize = CGSize(width: screenWidth/9, height: screenWidth/9)
        heartsArray.append(SKSpriteNode(imageNamed: "Assets/heart.png"))
        heartsArray.append(SKSpriteNode(imageNamed: "Assets/heart.png"))
        heartsArray.append(SKSpriteNode(imageNamed: "Assets/heart.png"))
        
        var counter : CGFloat = 0.0
        for heart in heartsArray {
            heart.size = heartSize
            heart.position = CGPoint(x: originX + screenWidth/20 + (screenWidth/12) * counter, y: originY + screenHeight * 12/13.0)
            self.addChild(heart)
            counter+=1.0
        }
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
        
        elapsedTime += Float(delta)
        let seconds = Int(elapsedTime % 60)
        let minutes = Int((elapsedTime / 60) % 60)
        timerLabel!.text = NSString(format: "%0.2d:%0.2d", minutes, seconds) as String
        
        lastInterval = currentTime
        
        if directionalPad!.direction != .None{
            var x: CGFloat = directionalPad!.getDirectionVector().dx * player!.moveSpeed * CGFloat(delta)
            var y: CGFloat = directionalPad!.getDirectionVector().dy * player!.moveSpeed * CGFloat(delta)
                        
            //Checks the map bounds
            if !tileMap!.layerNamed("Tile Layer 1").containsPoint(CGPointMake(player!.position.x + x, player!.position.y)) {
                x = 0.0            }
            if !tileMap!.layerNamed("Tile Layer 1").containsPoint(CGPointMake(player!.position.x, player!.position.y + y)) {
                y = 0.0
            }

            player!.move(x , yMove: y)
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
