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
        let buttonSize = CGSize(width: view!.frame.width/10, height: view!.frame.width/10)
        
        let zButton = SgButton(normalImageNamed: "Assets/blueButton.png", highlightedImageNamed: "Assets/bluePushed.png", buttonFunc: tappedButton)
        zButton.size = buttonSize
        zButton.position = CGPointMake(400, 400)
        
        let xButton = SgButton(normalImageNamed: "Assets/redButton.png", highlightedImageNamed: "Assets/redPushed.png", buttonFunc: tappedButton)
        xButton.size = buttonSize
        xButton.position = CGPointMake(400, 500)
        
        self.addChild(zButton)
        self.addChild(xButton)
    }
    
    func tappedButton(button: SgButton){
        print("button")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
