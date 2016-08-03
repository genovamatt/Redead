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
                isANewHighScore = false
            }
        }
        let gameOverLabel = SKLabelNode()
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+screenHeight/8)
        gameOverLabel.fontSize = 60
        gameOverLabel.fontName = "Zapfino"
        
        if GameScene.gameEndVariables.victory {
            gameOverLabel.text = "A+!"
            
            gameOverLabel.fontColor = SKColor.greenColor()
            
            
            let highScoreLabel = SKLabelNode()
            
            
            if !isANewHighScore! {
                let labelText = "High Score: \(defaults.objectForKey("HighScore")! as! String)"
                highScoreLabel.text = labelText
                highScoreLabel.fontColor = SKColor.brownColor()
            }
            else {
                let labelText = "NEW HIGH SCORE: \(defaults.objectForKey("HighScore")! as! String)"
                highScoreLabel.text = labelText
                highScoreLabel.fontColor = SKColor.magentaColor()
            }
            highScoreLabel.fontSize = 30
            highScoreLabel.fontName = "Zapfino"
            highScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - screenHeight/4)
            self.addChild(highScoreLabel)

        }
        else {
            gameOverLabel.text = "Game Over!"
            gameOverLabel.fontColor = SKColor.redColor()
        }
        
        self.addChild(gameOverLabel)
    }
    
    func addButtonsToScene(){
        let buttonSize = CGSize(width: screenWidth/4, height: screenWidth/8)
        
        let zButton = SgButton(normalImageNamed: "Assets/buttonStock.png", highlightedImageNamed: "Assets/buttonStockPressed.png", buttonFunc: tappedPlayAgainButton)
        zButton.size = buttonSize
        zButton.position = CGPointMake(x + screenWidth / 2, y + screenHeight / 2)
        
        let buttonLabel = SKLabelNode(text: "Play Again")
        buttonLabel.position = CGPointMake(buttonLabel.position.x, -10)
        buttonLabel.fontColor = SKColor.whiteColor()
        buttonLabel.fontSize = 30
        zButton.addChild(buttonLabel)
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

