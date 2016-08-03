//
//  GameOverScene.swift
//  Redead
//
//  Created by Jack Robards on 8/2/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    let screenWidth = ScreenHelper.instance.visibleScreen.width
    let screenHeight = ScreenHelper.instance.visibleScreen.height
    let x = ScreenHelper.instance.visibleScreen.origin.x
    let y = ScreenHelper.instance.visibleScreen.origin.y

    
    override func didMoveToView(view: SKView) {
        addTextToScreen()
        addButtonsToScene()
    }
    
    func addTextToScreen() {
        let time = GameScene.gameEndVariables.currentTime
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let oldHighScore = defaults.objectForKey("HighScore")
        var isANewHighScore: Bool?
        
        if oldHighScore == nil {
            defaults.setObject(time, forKey: "HighScore")
            isANewHighScore = true
        }
        else {
            if let stringOldScore = oldHighScore as? String {
                if stringOldScore >= time {
                    defaults.setObject(time, forKey: "HighScore")
                    isANewHighScore = true
                }
                isANewHighScore = false
            }
            else {
                print("o")
                isANewHighScore = false
            }
        }
        let gameOverLabel = SKLabelNode()
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+screenHeight/8)
        gameOverLabel.fontSize = 65
        
        if GameScene.gameEndVariables.victory {
            gameOverLabel.text = "You Win!"
            gameOverLabel.fontColor = SKColor.greenColor()
            
            
            let highScoreLabel = SKLabelNode()
            
            if isANewHighScore! {
                let labelText = "High Score: \(defaults.objectForKey("HighScore")! as! String)"
                let highScoreLabel = SKLabelNode(text: labelText)
                highScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - screenHeight/8)
                highScoreLabel.fontColor = SKColor.blackColor()
                highScoreLabel.fontSize = 40
                
            }
            else {
                let labelText = "NEW HIGH SCORE: \(defaults.objectForKey("HighScore")! as! String)"
                let highScoreLabel = SKLabelNode(text: labelText)
                highScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - screenHeight/8)
                highScoreLabel.fontColor = SKColor.magentaColor()
                highScoreLabel.fontSize = 80
            }
            self.addChild(highScoreLabel)

        }
        else {
            gameOverLabel.text = "Game Over!"
            gameOverLabel.fontColor = SKColor.redColor()
        }
        
        self.addChild(gameOverLabel)
    }
    
    func addButtonsToScene(){
        let buttonSize = CGSize(width: screenWidth/10, height: screenWidth/10)
        
        let zButton = SgButton(normalImageNamed: "Assets/blueButton.png", highlightedImageNamed: "Assets/bluePushed.png", buttonFunc: tappedPlayAgainButton)
        zButton.size = buttonSize
        zButton.position = CGPointMake(x + screenWidth / 2, y + screenHeight / 2)
        
        self.addChild(zButton)
    }
    
    func tappedPlayAgainButton(button: SgButton){
        let newScene = MenuScene(size: ScreenHelper.instance.sceneCoordinateSize)
        newScene.scaleMode = .AspectFill
        self.scene!.view!.presentScene(newScene)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

