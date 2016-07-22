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
    
    
    override func didMoveToView(view: SKView) {
        addMapToScene()
        addButtonsToScene()
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
        let tileMap = JSTileMap(named: "sample.tmx")
        
        self.addChild(tileMap)
    }
    
    func pushedXButton(button: SgButton){
        print("x button")
    }
    
    func pushedZButton(button: SgButton){
        print("z button")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if directionalPad!.direction != .None{
            print(directionalPad!.direction)
        }
    }
    
    
    }
