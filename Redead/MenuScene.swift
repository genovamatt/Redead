//
//  MenuScene.swift
//  Redead
//
//  Created by Matthew Genova on 7/20/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//


import SpriteKit

class MenuScene: SKScene {

    override func didMoveToView(view: SKView) {
        addButtonsToScene()
    }
    
    func addButtonsToScene(){
        let buttonSize = CGSize(width: view!.frame.width/10, height: view!.frame.width/10)
        
        let zButton = SgButton(normalImageNamed: "Assets/blueButton.png", highlightedImageNamed: "Assets/bluePushed.png", buttonFunc: tappedStartButton)
        zButton.size = buttonSize
        zButton.position = CGPointMake(frame.midX, frame.midY)
        
        self.addChild(zButton)
    }
    
    func tappedStartButton(button: SgButton){
        if let newScene = GameScene(fileNamed: "GameScene"){
            newScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view!.presentScene(newScene)
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

