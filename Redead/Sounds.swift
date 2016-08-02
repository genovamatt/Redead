//
//  Sounds.swift
//  Redead
//
//  Created by Labuser on 8/1/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import Foundation
import AVFoundation

class Sounds{
    
    /*
    *  SOUND STUFF
    *
    *
    */
    
    public let deathMusic = "Assets/Death Is Just Another Path_0"
    public let deathMusicExt = "mp3"
    public let dungeonMusic = "Assets/A Journey Awaits"
    public let dungeonMusicExt = "mp3"
    public let bossMusic = "Assets/boss theme"
    public let bossMusicExt = "mp3"
    
    private var backgroundSound = NSURL()
    private var backgroundAudioPlayer : AVAudioPlayer!
    
    public func setBackgroundMusic(musicPath: String, ofType: String)
    {
        backgroundSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(musicPath, ofType: ofType)!)
        do {
            backgroundAudioPlayer = try AVAudioPlayer(contentsOfURL: backgroundSound)
        }
        catch
        {
            backgroundAudioPlayer = nil
        }
        backgroundAudioPlayer.numberOfLoops = -1
        backgroundAudioPlayer.volume = 0.6
        backgroundAudioPlayer.prepareToPlay()
        backgroundAudioPlayer.play()
    }
    
    public let hitSound = "Assets/Hit"
    public let hitSoundExt = "wav"
    public let deathSound = "Assets/gameOverSound"
    public let deathSoundExt = "mp3"
    public let zombieDeathSound = "Assets/zombieDeathSoundQuestionMark"
    public let zombieDeathSoundExt = "mp3"
    
    private var tempSound = NSURL()
    private var tempAudioPlayer : AVAudioPlayer!
    
    public func playTempSound(soundPath: String, ofType: String)
    {
        tempSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundPath, ofType: ofType)!)
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
