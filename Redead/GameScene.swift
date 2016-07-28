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
    var initialized = false
    
    private var yCameraAdjust: CGFloat = 0.0
    private var xCameraAdjust: CGFloat = 0.0
    private let screenWidth = ScreenHelper.instance.visibleScreen.width
    private let screenHeight = ScreenHelper.instance.visibleScreen.height
    private let originX = ScreenHelper.instance.visibleScreen.origin.x
    private let originY = ScreenHelper.instance.visibleScreen.origin.y
    private let sceneCoordinatesX = ScreenHelper.instance.sceneCoordinateSize.width
    private let sceneCoordinatesY = ScreenHelper.instance.sceneCoordinateSize.height
    
    override func didMoveToView(view: SKView) {
        yCameraAdjust = -CGRectGetMidY(self.frame) + screenHeight/6
        xCameraAdjust = -CGRectGetMidX(self.frame)
        addCameraToScene()
        addButtonsToScene()
        addPlayerToScene()
        addMapToScene("XMLSampleLayers.tmx")
        addHeartsToScene()
        addTimerToScene()
        setBackgroundMusic("Assets/A_Journey_Awaits")
        
        self.camera!.position = CGPoint(x: -xCameraAdjust, y: -yCameraAdjust)
        initialized = true
    }
    
    func addCameraToScene() {
        let cam: SKCameraNode! = SKCameraNode()
        
        self.camera = cam
        self.addChild(cam)
        
        cam.position = CGPoint(x: originX, y: originY)
    }
    
    func addTimerToScene(){
        timerLabel = SKLabelNode(text: "00:00")
        timerLabel!.position = CGPointMake(originX + screenWidth * 18/20.0 + xCameraAdjust, originY + screenHeight * 18/20.0 + yCameraAdjust)
        self.camera!.addChild(timerLabel!)
    }
    
    func addButtonsToScene(){
        let buttonSize = CGSize(width: screenWidth/10, height: screenWidth/10)
        let zButton = SgButton(normalImageNamed: "Assets/blueButton.png", highlightedImageNamed: "Assets/bluePushed.png", buttonFunc: InputManager.instance.pushedZButton)
        zButton.size = buttonSize
        zButton.position = CGPointMake(originX + screenWidth * 16/20.0 + xCameraAdjust, originY + screenHeight * 4/16.0 + yCameraAdjust)
        
        let xButton = SgButton(normalImageNamed: "Assets/redButton.png", highlightedImageNamed: "Assets/redPushed.png", buttonFunc: InputManager.instance.pushedXButton)
        xButton.size = buttonSize
        xButton.position = CGPointMake(originX + screenWidth * 18/20.0 + xCameraAdjust, originY + screenHeight * 2/16.0 + yCameraAdjust)
        
        self.camera!.addChild(zButton)
        self.camera!.addChild(xButton)
        
        let dPadSize = CGSize(width: screenWidth/5, height: screenWidth/5)

        directionalPad = DirectionalPad(imageName: "Assets/flatDark08.png", size: dPadSize)
        
        directionalPad!.position = CGPointMake(originX + screenWidth * 1/8.0 + xCameraAdjust, originY + screenHeight * 5/22.0 + yCameraAdjust)
        self.camera!.addChild(directionalPad!)
        InputManager.instance.setDirectionalPad(directionalPad!)
    }
    
    func addMapToScene(mapName: String) {
        
        if (tileMap != nil) {
            player!.removeFromParent()
            tileMap!.removeFromParent()
            self.camera!.position = CGPoint(x: -xCameraAdjust, y: -yCameraAdjust)
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
            heart.position = CGPoint(x: originX + screenWidth/20 + xCameraAdjust + (screenWidth/12) * counter, y: originY + yCameraAdjust + screenHeight * 12/13.0)
            self.camera!.addChild(heart)
            counter+=1.0
        }
    }
    
    func addPlayerToScene() {
        player = Player()
    }
    
       
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        //Controls the players movement
        
        if initialized{
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
            
            let layer = tileMap!.layerNamed("MovableMap")
            let gid = layer.tileGidAt(player!.position)
            
            if gid == 3 {
                if tileMap!.name == "XMLSampleLayers.tmx" {
                    addMapToScene("secondMap.tmx")
                }
                else if tileMap!.name == "secondMap.tmx" {
                    addMapToScene("XMLSampleLayers.tmx")
                }
            }

            
            //Handles the scrolling of the map vertically. Currently there is no horizontal scrolling.
            if player!.position.y > self.camera!.position.y + 20 {
                self.camera!.position = CGPointMake(self.camera!.position.x, self.camera!.position.y + 2.0)
            }
            else if player!.position.y < self.camera!.position.y - 20 {
                self.camera!.position = CGPointMake(self.camera!.position.x, self.camera!.position.y - 2.0)
            }
            
            InputManager.instance.update()

        }
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
