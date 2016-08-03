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
        let screenWidth = ScreenHelper.instance.visibleScreen.width
        let screenHeight = ScreenHelper.instance.visibleScreen.height
        let x = ScreenHelper.instance.visibleScreen.origin.x
        let y = ScreenHelper.instance.visibleScreen.origin.y

        let buttonSize = CGSize(width: 500, height: 200)
        
        let zButton = SgButton(normalImageNamed: "Assets/buttonStock.png", highlightedImageNamed: "Assets/buttonStockPressed.png", buttonFunc: tappedStartButton)
        zButton.size = buttonSize
        zButton.position = CGPointMake(x + screenWidth / 2, y + screenHeight / 2)
        
        self.addChild(zButton)
        let label = SKLabelNode(text: "Start Redead")
        label.fontName = "AmericanTypewriter-Bold"
        label.fontColor = UIColor.yellowColor()
        label.zPosition = 0.1
        zButton.addChild(label)
    }
    
    func tappedStartButton(button: SgButton){
        let newScene = GameScene(size: ScreenHelper.instance.sceneCoordinateSize)
        newScene.scaleMode = .AspectFill
        self.scene!.view!.presentScene(newScene)
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

