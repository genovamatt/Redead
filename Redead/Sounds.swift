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
    
    let deathMusic = "Assets/Death Is Just Another Path_0"
    let deathMusicExt = "mp3"
    let dungeonMusic = "Assets/A_Journey_Awaits"
    let dungeonMusicExt = "mp3"
    let bossMusic = "Assets/boss_theme"
    let bossMusicExt = "mp3"
    
    private var backgroundSound = NSURL()
    private var backgroundAudioPlayer : AVAudioPlayer!
    
    func setBackgroundMusic(musicPath: String, ofType: String)
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
        backgroundAudioPlayer.volume = 0.3
        backgroundAudioPlayer.prepareToPlay()
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            self.backgroundAudioPlayer.play()
        })
    }
    
    let hitSound = "Assets/Hit"
    let hitSoundExt = "wav"
    let deathSound = "Assets/gameOverSound"
    let deathSoundExt = "mp3"
    let zombieDeathSound = "Assets/zombieDeathSoundQuestionMark"
    let zombieDeathSoundExt = "mp3"
    
    private var tempSound = NSURL()
    private var tempAudioPlayer : AVAudioPlayer!
    
    func playTempSound(soundPath: String, ofType: String)
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
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            self.tempAudioPlayer.play()
        })
    }
    
}
