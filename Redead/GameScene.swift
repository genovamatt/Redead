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
    
    override func didMoveToView(view: SKView) {
        
        addButtonsToScene()
        addPlayerToScene()
        addMapToScene()
    }
    
    func addButtonsToScene(){
        let screenWidth = ScreenHelper.instance.visibleScreen.width
        let screenHeight = ScreenHelper.instance.visibleScreen.height
        let x = ScreenHelper.instance.visibleScreen.origin.x
        let y = ScreenHelper.instance.visibleScreen.origin.y
        
        let buttonSize = CGSize(width: screenWidth/10, height: screenWidth/10)
        let zButton = SgButton(normalImageNamed: "Assets/blueButton.png", highlightedImageNamed: "Assets/bluePushed.png", buttonFunc: pushedZButton)
        zButton.size = buttonSize
        zButton.position = CGPointMake(x + screenWidth * 16/20.0, y + screenHeight * 4/16.0)
        
        let xButton = SgButton(normalImageNamed: "Assets/redButton.png", highlightedImageNamed: "Assets/redPushed.png", buttonFunc: pushedXButton)
        xButton.size = buttonSize
        xButton.position = CGPointMake(x + screenWidth * 18/20.0, y + screenHeight * 2/16.0)
        
        self.addChild(zButton)
        self.addChild(xButton)
        
        let dPadSize = CGSize(width: screenWidth/5, height: screenWidth/5)

        directionalPad = DirectionalPad(imageName: "Assets/flatDark08.png", size: dPadSize)
        
        directionalPad!.position = CGPointMake( x + screenWidth * 1/8.0, y + screenHeight * 5/22.0)
        self.addChild(directionalPad!)
    }
    
    func addMapToScene() {
        let screenWidth = ScreenHelper.instance.visibleScreen.width
        let screenHeight = ScreenHelper.instance.visibleScreen.height
        let x = ScreenHelper.instance.visibleScreen.origin.x
        let y = ScreenHelper.instance.visibleScreen.origin.y
        
        let tileMap = JSTileMap(named: "iso-test-1.tmx")
        tileMap.position = CGPoint(x: x + screenWidth/5, y: y + screenHeight/5)
        print(tileMap.layers![0].description)
        tileMap.addChild(player!)
        
        self.addChild(tileMap)
    }
    
    func addPlayerToScene() {
        let screenWidth = ScreenHelper.instance.visibleScreen.width
        let screenHeight = ScreenHelper.instance.visibleScreen.height
        let x = ScreenHelper.instance.visibleScreen.origin.x
        let y = ScreenHelper.instance.visibleScreen.origin.y
        
        player = Player(imageName: "Assets/Placeholder_Character.png", size: CGSizeMake(x + screenHeight/20, x + screenHeight/20))
        player!.position = CGPointMake(x + screenWidth * 1/2.0, y + screenHeight * 1/2.0)
        //self.addChild(player!)
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
        if directionalPad!.direction != .None{
            var x: CGFloat = 0.0
            var y: CGFloat = 0.0
            let moveUpOrRight: CGFloat = 1.0
            let moveDownOrLeft: CGFloat = -1.0
            let moveDiagnolLeftOrDown: CGFloat = -0.75
            let moveDiagnolRightOrUp: CGFloat = 0.75
            
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
            player!.move(x, yMove: y)
        }
    }
    
    
    }
