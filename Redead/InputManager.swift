//
//  InputManager.swift
//  Redead
//
//  Created by Matthew Genova on 7/26/16.
//  Copyright © 2016 Matthew Genova. All rights reserved.
//

import Foundation

class InputManager{
    static let instance = InputManager()
    var directionalPad: DirectionalPad? = nil
    var xButtonPressedInFrame = false
    var zButtonPressedInFrame = false
    
    func setDirectionalPad(directionalPad: DirectionalPad){
        self.directionalPad = directionalPad
    }
    
    func pushedXButton(button: SgButton){
        xButtonPressedInFrame = true
    }
    
    func pushedZButton(button: SgButton){
        zButtonPressedInFrame = true
    }
    
    func getDpadDirection() -> DirectionalPad.Direction{
        if directionalPad != nil{
            return directionalPad!.direction
        }
        
        return DirectionalPad.Direction.None
    }
    
    func getDpadDirectionVector() -> CGVector{
        if directionalPad != nil{
            return directionalPad!.getDirectionVector()
        }
        
        return CGVector(dx: 0,dy: 0)
    }
    
    func update(){
        xButtonPressedInFrame = false
        zButtonPressedInFrame = false
    }
    
}