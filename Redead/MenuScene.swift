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
        let buttonSize = CGSize(width: Helper.visibleScreen.width/10, height: Helper.visibleScreen.width/10)
        
        let zButton = SgButton(normalImageNamed: "Assets/blueButton.png", highlightedImageNamed: "Assets/bluePushed.png", buttonFunc: tappedStartButton)
        zButton.size = buttonSize
        zButton.position = CGPointMake(Helper.visibleScreen.origin.x + Helper.visibleScreen.width / 2, Helper.visibleScreen.origin.y + Helper.visibleScreen.height / 2)
        
        self.addChild(zButton)
    }
    
    func tappedStartButton(button: SgButton){
        let newScene = GameScene(size: CGSize(width: Helper.sceneCoordinatesWidth , height: Helper.sceneCoordinatesHeight))
        newScene.scaleMode = .AspectFill
        self.scene!.view!.presentScene(newScene)
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

