//
//  GameScene.swift
//  Redead
//
//  Created by Matthew Genova on 7/18/16.
//  Copyright (c) 2016 Matthew Genova. All rights reserved.
//

import SpriteKit
import AVFoundation


class GameScene: SKScene, SKPhysicsContactDelegate {
    var directionalPad:DirectionalPad? = nil
    var player:Player? = nil
    var tileMap:JSTileMap? = nil
    var enemy: Enemy? = nil
    
    var lastInterval: CFTimeInterval?
    var elapsedTime: Float = 0.0
    var timerLabel: SKLabelNode? = nil
    var initialized = false
    let maps: [String: String] = ["FirstMap.tmx": "secondMap.tmx", "secondMap.tmx": "ThirdMap.tmx", "ThirdMap.tmx": "FirstMap.tmx"]
    
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
        addMapToScene("FirstMap.tmx")
        addHeartsToScene()
        addTimerToScene()
        //setBackgroundMusic("Assets/A_Journey_Awaits")
        enemy = Enemy(level: Difficulty.Easy, thePlayer: player!)
        
        tileMap!.addChild(enemy!)
        enemy!.position = CGPoint(x: tileMap!.tileSize.width * 5, y: tileMap!.tileSize.height * 4)
        self.addChild(tileMap!)
        self.camera!.position = CGPoint(x: -xCameraAdjust, y: tileMap!.tileSize.height * 2.2)
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0,0)
        
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
            self.camera!.position = CGPoint(x: -xCameraAdjust, y: tileMap!.tileSize.height * 2.2)
            tileMap!.removeFromParent()
        }
        tileMap = JSTileMap(named: mapName)
        TileManager.instance.setTileMap(tileMap!)
        tileMap!.position = CGPoint(x: originX + screenWidth/4, y: originY + screenHeight/12)
        tileMap!.name = mapName
        
        //Made it so the player is a child of the map, not the scene
        tileMap!.addChild(player!)
        player!.position = CGPoint(x: tileMap!.tileSize.width * 1.5, y: tileMap!.tileSize.height * 2)
        
        //self.addChild(tileMap!)
    }
    
    func addHeartsToScene() {
        let heartSize = CGSize(width: screenWidth/9, height: screenWidth/9)
        
        var counter : CGFloat = 0.0
        for heart in player!.heartsArray {
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
            enemy!.update(delta)
            
            let layer = tileMap!.layerNamed("MovableMap")
            let gid = layer.tileGidAt(player!.position)
            
            if gid == 3 {
                addMapToScene(maps[tileMap!.name!]!)
            }

            
            //Handles the scrolling of the map vertically.
            let cameraSpeed: CGFloat = 2.0
            if player!.position.y > self.camera!.position.y + 20 {
                self.camera!.position = CGPointMake(self.camera!.position.x, self.camera!.position.y + cameraSpeed)
            }
            else if player!.position.y < self.camera!.position.y - 20 {
                self.camera!.position = CGPointMake(self.camera!.position.x, self.camera!.position.y - cameraSpeed)
            }
            
            //Handles the scrolling of the map horizontally.
            if player!.position.x - xCameraAdjust > self.camera!.position.x + 95  {
                self.camera!.position = CGPointMake(self.camera!.position.x + cameraSpeed, self.camera!.position.y)
            } //account for camera adjust
            else if player!.position.x - xCameraAdjust < self.camera!.position.x - 95 {
                self.camera!.position = CGPointMake(self.camera!.position.x - cameraSpeed, self.camera!.position.y)
            }
            
            InputManager.instance.update()

        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstNode = contact.bodyA.node as! SKSpriteNode
        let secondNode = contact.bodyB.node as! SKSpriteNode
        print("contact")
        
    
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
