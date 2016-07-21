//
//  GameScene.swift
//  Redead
//
//  Created by Matthew Genova on 7/18/16.
//  Copyright (c) 2016 Matthew Genova. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!"
//        myLabel.fontSize = 45
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
//        
//        
//        self.addChild(myLabel)
        
        addButtonsToScene()
        
    }
    
    func addButtonsToScene(){
        let screenWidth = Helper.visibleScreen.width
        let screenHeight = Helper.visibleScreen.height
        let x = Helper.visibleScreen.origin.x
        let y = Helper.visibleScreen.origin.y
        
        let buttonSize = CGSize(width: screenWidth/20, height: screenWidth/20)
        let zButton = SgButton(normalImageNamed: "Assets/blueButton.png", highlightedImageNamed: "Assets/bluePushed.png", buttonFunc: tappedButton)
        zButton.size = buttonSize
        zButton.position = CGPointMake(x + screenWidth * 13/16.0, y + screenHeight * 3/16.0)
        
        let xButton = SgButton(normalImageNamed: "Assets/redButton.png", highlightedImageNamed: "Assets/redPushed.png", buttonFunc: tappedButton)
        xButton.size = buttonSize
        xButton.position = CGPointMake(x + screenWidth * 14/16.0, y + screenHeight * 2/16.0)
        
        self.addChild(zButton)
        self.addChild(xButton)
        
        let dPadSize = CGSize(width: screenWidth/8, height: screenWidth/8)

        let dPad = DirectionalPad(imageName: "Assets/flatDark08.png", size: dPadSize)
        
        dPad.position = CGPointMake( x + screenWidth * 1/8.0, y + screenHeight * 3/16.0)
        self.addChild(dPad)
    }
    
    func tappedButton(button: SgButton){
        print("button")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    }
