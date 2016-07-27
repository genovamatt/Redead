//
//  GameScene.swift
//  Redead
//
//  Created by Matthew Genova on 7/18/16.
//  Copyright (c) 2016 Matthew Genova. All rights reserved.
//

import SpriteKit
import AVFoundation


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
        addMapToScene("XMLSampleLayers.tmx")
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
        let zButton = SgButton(normalImageNamed: "Assets/blueButton.png", highlightedImageNamed: "Assets/bluePushed.png", buttonFunc: InputManager.instance.pushedZButton)
        zButton.size = buttonSize
        zButton.position = CGPointMake(originX + screenWidth * 16/20.0, originY + screenHeight * 4/16.0)
        
        let xButton = SgButton(normalImageNamed: "Assets/redButton.png", highlightedImageNamed: "Assets/redPushed.png", buttonFunc: InputManager.instance.pushedXButton)
        xButton.size = buttonSize
        xButton.position = CGPointMake(originX + screenWidth * 18/20.0, originY + screenHeight * 2/16.0)
        
        self.addChild(zButton)
        self.addChild(xButton)
        
        let dPadSize = CGSize(width: screenWidth/5, height: screenWidth/5)

        directionalPad = DirectionalPad(imageName: "Assets/flatDark00.png", size: dPadSize)
        
        directionalPad!.position = CGPointMake(originX + screenWidth * 1/8.0, originY + screenHeight * 5/22.0)
        self.addChild(directionalPad!)
        InputManager.instance.setDirectionalPad(directionalPad!)
    }
    
    func addMapToScene(mapName: String) {
        
        if (tileMap != nil) {
            player!.removeFromParent()
            tileMap!.removeFromParent()
        }
        tileMap = JSTileMap(named: mapName)
        TileManager.instance.setTileMap(tileMap!)
        tileMap!.position = CGPoint(x: originX + screenWidth/4, y: originY + screenHeight/12)
        tileMap!.name = mapName
        
        //Made it so the player is a child of the map, not the scene
        tileMap!.addChild(player!)
        player!.position = CGPoint(x: screenWidth/4, y: screenHeight/2)
        
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
        player = Player(imageName: "Assets/Placeholder_Character.png", size: CGSizeMake(screenWidth/12, screenWidth/12))
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
        
        player!.update(delta)
        
        if tileMap!.layerNamed("ExitMap").containsPoint(CGPointMake(player!.position.x, player!.position.y)) {
            print(tileMap!.filename)
            print(tileMap!.name!)
            if (tileMap!.name == "XMLSampleLayers.tmx") {
                addMapToScene("secondMap.tmx")
            }
            else {
                addMapToScene("XMLSampleLayers.tmx")
            }
        }
        
        //last thing in update
        InputManager.instance.update()
        
        
        /* Can use this sort of setup to determine what layer the player is currently a part of
        if (tileMap!.layerNamed("Tile Layer 4").containsPoint(player!.position)) {
            print("Death")
        }
        else {
            print("Life")
        }*/
    }
    
    /*
     *  SOUND STUFF
     *
     *
     */
    
    let deathMusic = "Assets/Death Is Just Another Path_0"
    let dungeonMusic = "Assets/A Journey Awaits"
    let bossMusic = "Assets/boss theme"
    
    private var backgroundSound = NSURL()
    private var backgroundAudioPlayer : AVAudioPlayer!
    
    func setBackgroundMusic(musicPath: String)
    {
        backgroundSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(musicPath, ofType: "mp3")!)
        do {
            backgroundAudioPlayer = try AVAudioPlayer(contentsOfURL: backgroundSound)
        }
        catch
        {
            backgroundAudioPlayer = nil
        }
        backgroundAudioPlayer.numberOfLoops = -1
        backgroundAudioPlayer.prepareToPlay()
        backgroundAudioPlayer.play()
    }
    
    let hitSound = "Assets/Hit"
    let deathSound = "Assets/gameOverSound"
    let zombieDeathSound = "Assets/zombieDeathSound"
    
    private var tempSound = NSURL()
    private var tempAudioPlayer : AVAudioPlayer!
    
    func playTempSound(soundPath: String)
    {
        tempSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundPath, ofType: "mp3")!)
        do {
            tempAudioPlayer = try AVAudioPlayer(contentsOfURL: tempSound)
        }
        catch
        {
            tempAudioPlayer = nil
        }
        
        tempAudioPlayer.prepareToPlay()
        tempAudioPlayer.play()
    }

    
    
}
